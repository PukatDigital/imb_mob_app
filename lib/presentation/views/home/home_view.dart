import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/set_up_profile_dialog.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/top_tabs.dart';
import 'package:provider/provider.dart';

import '../../../application/network/result.dart';
import '../../../widgets/toast.dart';
import 'home_view_model.dart';
import 'match_card.dart';

enum HomeTab { matched, forYou }

class HomeView extends BaseStateFullWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements ErrorResult {
  HomeTab selectedTab = HomeTab.matched;

  final PageController _pageController = PageController();
  bool _dialogShown = false;
  int _currentIndex = 0;

  void _handleProfileDialog(int index) {
    final list = context.read<GetProfileViewModel>().profiles;

    /// safe check (avoid crash if list < 4)
    if (list.length <= 3) return;

    if (index == 3 && !_dialogShown) {
      _dialogShown = true;

      Future.delayed(const Duration(milliseconds: 200), () async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (_) => SetUpProfileDialog(),
        );

        _dialogShown = false;
      });
    }
  }
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<GetProfileViewModel>().getAllProfiles(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Consumer<GetProfileViewModel>(
        builder: (context, viewModel, _) {
          final profileCom =
              viewModel.getProfileModel.data?.profileCompleted ?? 0;

          final fullList = viewModel.profiles;

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
                    onTabChange: (tab) {
                      setState(() {
                        selectedTab = tab;
                      });
                    },
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
}