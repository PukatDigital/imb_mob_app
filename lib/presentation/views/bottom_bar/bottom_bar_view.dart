import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/routes/route_generator.dart';
import '../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';
import '../chat/chat_list_view.dart';
import '../explore/explore_view.dart';
import '../favourite/favourite_view.dart';
import '../home/home_view.dart';
import '../profile/profile_view.dart';
import '../profile/profile_view_model.dart';

class BottomBarView extends BaseStateFullWidget {
  BottomBarView({super.key});

  static final GlobalKey<_BottomBarViewState> globalKey =
  GlobalKey<_BottomBarViewState>();

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> implements Result {
  int _selectedIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _buildScreens();

    // ✅ Fetch deactivation status after first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDeactivationStatus();
    });
  }

  /// ✅ Fetch profile deactivation status and show dialog if deactivated
  void _checkDeactivationStatus() {
    final login = widget.iPrefHelper.loginModel;
    final profileId = login?.data?.user?.name?.toString();

    if (profileId == null) return;

    final data = {"email": profileId};

    context
        .read<GetPersonalProfileViewModel>()
        .getDeactivateProfile(data, _DeactivateCheckResult(context, widget.dimens, this));
  }

  void _buildScreens() {
    _screens.clear();
    _screens.addAll([
      HomeView(),
      ExploreView(),
      FavouriteView(),
      ChatListView(),
      ProfileScreen(),
    ]);
  }

  void switchTab(int index) {
    if (index < 0 || index >= _screens.length) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  void openNewDocumentWithArgs(Map<String, dynamic> args) {
    setState(() {
      _selectedIndex = 1;
      _buildScreens();
    });
  }

  void _onItemTapped(int index) {
    switchTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey,
      body: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: 10,
          bottom: 10      + MediaQuery.of(context).padding.bottom,
        ),
        decoration: BoxDecoration(
          color: ColorManager.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return _buildNavItem(index);
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final icons = [
      Assets.home,
      Assets.explore,
      Assets.favorite,
      Assets.chat,
      Assets.profile,
    ];
    final labels = ["Home", "Explore", "Favorite", "Chat", "Profile"];

    final isSelected = index == _selectedIndex;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
        EdgeInsets.symmetric(horizontal: isSelected ? 16 : 0, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? ColorManager.primary.withOpacity(.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Image.asset(
              icons[index].toString(),
              height: widget.dimens.k25,
              width: widget.dimens.k25,
              color: isSelected
                  ? ColorManager.primary
                  : ColorManager.fieldTextColor,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                labels[index],
                style: TextStyle(
                  color: ColorManager.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // ✅ Deactivate dialog — shown when profileDeactive == 0
  void showDeactivateDialouge(BuildContext context, dynamic dimens) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (_) {
        return PopScope(
          canPop: false, // ✅ intercept all pops
          onPopInvoked: (didPop) {
            if (didPop) return;
            // ✅ navigate to login when tapped outside or back button pressed
            widget.iPrefHelper.clear();
            Navigator.pushNamedAndRemoveUntil(
              context,
              RouteManager.rLoginView,
                  (route) => false,
            );
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(dimens.k24),
              ),
              insetPadding: EdgeInsets.symmetric(horizontal: dimens.k20),
              child: Padding(
                padding: EdgeInsets.all(dimens.k24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: dimens.k5),
                    Text(
                      'Activate your account?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: dimens.k24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: dimens.k12),
                    Text(
                      'Your profile is currently deactivated.\nOther users cannot see or contact you.\nActivate to become visible again.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: dimens.k15,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: dimens.k30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              const Color(0xFFB11E24).withOpacity(.18),
                              padding: EdgeInsets.symmetric(vertical: dimens.k16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(dimens.k40),
                              ),
                            ),
                            onPressed: () {
                              // ✅ No button also goes to login
                              widget.iPrefHelper.clear();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteManager.rLoginView,
                                    (route) => false,
                              );
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: dimens.k16,
                                fontWeight: FontWeight.w600,
                                color: ColorManager.rejectedText,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: dimens.k12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: ColorManager.rejectedText,
                              padding: EdgeInsets.symmetric(vertical: dimens.k16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(dimens.k40),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              final data = {"profile_deactive": 0};
                              context
                                  .read<GetPersonalProfileViewModel>()
                                  .deactivateAccount(data, this);
                            },
                            child: Text(
                              'Activate',
                              style: TextStyle(
                                fontSize: dimens.k16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ✅ Result callbacks for deactivateAccount (activate button press)
  @override
  void onError(String error) {
    MyToast.showToast(message:error, typeToast: TypeToast.error);
  }

  @override
  void onSuccess(result) {
    // Called after user taps Activate and API succeeds
    MyToast.showToast(message:result, typeToast: TypeToast.success);
  }
}

/// ✅ Separate Result handler for the deactivation STATUS CHECK on login
class _DeactivateCheckResult implements Result {
  final BuildContext context;
  final dynamic dimens;
  final _BottomBarViewState state;

  _DeactivateCheckResult(this.context, this.dimens, this.state);

  @override
  void onError(String error) {
    // Silently fail — don't block user on a status check error
    debugPrint("Deactivation check error: $error");
  }


  @override
  void onSuccess(result) {
    final vm = context.read<GetPersonalProfileViewModel>();
    final profileDeactive = vm.deactivateProfileModel.data?.profileDeactive;

    if (profileDeactive == 1) { // ✅ 1 = deactivated → show dialog
      state.showDeactivateDialouge(context, dimens);
    }
  }
}