 import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/set_up_profile_dialog.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/top_tabs.dart';
import 'package:provider/provider.dart';

import '../../../application/network/result.dart';
import '../../../data/models/explore_model/explore_model.dart';
import '../../../widgets/toast.dart';
import 'home_view_model.dart';
import 'match_card.dart';

enum HomeTab { matched, forYou }

class HomeView extends BaseStateFullWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements ErrorResult, Result<String> {
  HomeTab selectedTab = HomeTab.forYou;


  final PageController _pageController = PageController();
  bool _dialogShown = false;
  int _currentIndex = 0;
  void _onTabChange(HomeTab tab) {
    setState(() => selectedTab = tab);

    if (tab == HomeTab.matched) {
      context.read<GetProfileViewModel>().exploreList(this, filterParams: _filterParams);
    } else if (tab == HomeTab.forYou) {
      context.read<GetProfileViewModel>().getAllProfiles(this);
    }
  }
  // void _onTabChange(HomeTab tab) {
  //   setState(() => selectedTab = tab);
  //
  //   if (tab == HomeTab.matched) {
  //     context.read<ExploreViewModel>().exploreList(this, filterParams: {});
  //   }
  // }
  void _handleProfileDialog(int index) {
    final list = context.read<GetProfileViewModel>().profiles;

    /// safe check (avoid crash if list < 4)
    if (list.length <= 3) return;

    if (index == 3 && !_dialogShown) {
      _dialogShown = true;

      Future.delayed(const Duration(milliseconds: 200), () async {
        await showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Colors.transparent,
          builder: (_) => PopScope(
            canPop: false,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: SetUpProfileDialog(),
              ),
            ),
          ),
        );

        _dialogShown = false;
      });
    }
  }
  List<Profiles> _mapExploreToProfiles(List<ExploreProfiles>? exploreList) {
    if (exploreList == null) return [];
    return exploreList.map((e) {
      return Profiles(
        profileId: e.profileId,
        userId: e.userId,
        profileName: e.profileName,
        dateOfBirth: e.dateOfBirth,
        location: e.location,

        profilePicture: e.profilePicture,
        attachments: e.attachments != null
            ? Attachments(
          attach1: e.attachments!.attach1,
          attach2: e.attachments!.attach2,
          attach3: e.attachments!.attach3,
          attach4: e.attachments!.attach4,
        )
            : null,
        profileCompleted: e.profileCompleted,
        isFavourite: e.isFavourite,
        isBlocked: e.isBlocked,
        noOfTimesAddedAsFavourite: e.noOfTimesAddedAsFavourite,
        noOfTimesGetBlocked: e.noOfTimesGetBlocked,
      );
    }).toList();
  }
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final myUserId = widget.iPrefHelper.loginModel?.data?.user?.name?.trim() ?? '';
      debugPrint('🔍 myUserId being passed: $myUserId'); // check this
      context.read<GetProfileViewModel>().getAllProfiles(this);
      context.read<GetProfileViewModel>().getMyProfileCompleted(myUserId);
      context.read<GetProfileViewModel>().exploreList(this, filterParams:_filterParams);
      debugPrint('🧠 ViewModel instance in initState: ${context.read<GetProfileViewModel>().hashCode}');
      debugPrint('🔍 login model: ${widget.iPrefHelper.loginModel?.data?.toJson()}');
      debugPrint('🔍 all pref keys: ${widget.iPrefHelper.loginModel?.data?.user?.apiKey}');
    });
  }
  final Map<String, dynamic> _filterParams = {

  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.border,
      extendBodyBehindAppBar: true,
      body: Consumer<GetProfileViewModel>(
        builder: (context, viewModel, _) {
          final profileCom =
              viewModel.getProfileModel.data?.profileCompleted ?? 0;

          final fullList = selectedTab == HomeTab.matched
              ? _mapExploreToProfiles(viewModel.exploreDataModel.data?.profiles)
              : viewModel.profiles;

          // 👉 Restrict list if profile not completed
          final currentList = profileCom == 1
              ? fullList
              : (fullList.length > 4 ? fullList.sublist(0, 4) : fullList);

          return Stack(

            children: [
              /// 🔹 Vertical PageView
              if (currentList.isNotEmpty)
                // PageView.builder(
                //   controller: _pageController,
                //   scrollDirection: Axis.vertical,
                //   itemCount: currentList.length,
                //
                //   onPageChanged: (index) {
                //     final profileCom =
                //         context.read<GetProfileViewModel>()
                //             .getProfileModel.data?.profileCompleted ?? 0;
                //
                //     // update current index
                //     _currentIndex = index;
                //
                //     /// 🚨 ONLY when profile incomplete
                //     if (profileCom == 0) {
                //       if (index == 3 && !_dialogShown) {
                //         _dialogShown = true;
                //
                //         Future.delayed(Duration(milliseconds: 200), () async {
                //           await showDialog(
                //             context: context,
                //             barrierDismissible: true,
                //             builder: (_) => SetUpProfileDialog(),
                //           );
                //
                //           // 🔥 reset AFTER dialog closes
                //           _dialogShown = false;
                //         });
                //       }
                //     }
                //   },
                //
                //   itemBuilder: (_, index) {
                //     return MatchCard(
                //       profile: currentList[index],
                //       selectedTab: selectedTab,
                //       onTabChange: (tab) {
                //         setState(() => selectedTab = tab);
                //       },
                //     );
                //   },
                // ),
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: currentList.length,

                  onPageChanged: (index) {
                    final profileCom =
                        context.read<GetProfileViewModel>()
                            .getProfileModel.data?.profileCompleted ?? 0;

                    setState(() {
                      _currentIndex = index;
                    });

                    /// 🚨 ONLY if profile is incomplete
                    if (profileCom == 0) {
                      _handleProfileDialog(index);
                    }
                  },

                  itemBuilder: (_, index) {
                    return MatchCard(
                      profile: currentList[index],
                      onRefresh: () {},
                    );
                  },
                ),
              /// 🔹 Loading
              if (viewModel.apiResponse is Loading)
                const Center(child: CircularProgressIndicator()),

              /// 🔹 Top Tabs (fixed)
              SafeArea(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: TopTabs(

                    selectedTab: selectedTab,
                    onTabChange: _onTabChange,
                    // onTabChange: (tab) {
                    //   setState(() {
                    //     selectedTab = tab;
                    //   });
                    // },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  onSuccess(String result) {
    // TODO: implement onSuccess
    // throw UnimplementedError();
  }
}