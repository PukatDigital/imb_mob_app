import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/set_up_profile_dialog.dart';
import 'package:ideal_marriage_bureau/presentation/views/home/user_profile/user_profile_details.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/toast.dart';
import 'home_view_model.dart';
import 'profile_info.dart';
import 'action_button.dart';

class MatchCard extends BaseStateLessWidget {
  final Profiles profile;
  final Function() onRefresh; // optional future use

  MatchCard({
    super.key,
    required this.profile,
    required this.onRefresh,
  });

  List<String> get _images {
    final List<String> imgs = [];

    if (profile.profilePicture != null) {
      imgs.add(profile.profilePicture!);
    }

    final a = profile.attachments;
    if (a != null) {
      if (a.attach1 != null) imgs.add(a.attach1!);
      if (a.attach2 != null) imgs.add(a.attach2!);
      if (a.attach3 != null) imgs.add(a.attach3!);
      if (a.attach4 != null) imgs.add(a.attach4!);
    }

    return imgs;
  }

  @override
  Widget build(BuildContext context) {
    final login = iPrefHelper.loginModel;
    final viewModel = context.read<GetProfileViewModel>();

    debugPrint('🧠 ViewModel instance in MatchCard: ${context.read<GetProfileViewModel>().hashCode}');
    final screenHeight = MediaQuery.of(context).size.height;
    final bottomPadding = MediaQuery.of(context).padding.bottom; // ✅ accounts for gesture/button nav
    final bottomNavHeight =  bottomPadding; // ✅ your actual bottom nav bar height

    return Stack(
      children: [
        /// IMAGE VIEW
        Positioned.fill(
          child: PageView.builder(
            controller: PageController(),
            itemCount: _images.isNotEmpty ? _images.length : 1,
            itemBuilder: (_, index) {
              return _images.isNotEmpty
                  ? Image.network(
                _images[index],
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
                  : _placeholder();
            },
          ),
        ),

        /// RIGHT ACTION BUTTONS
        Positioned(
          right: dimens.k16,
          bottom: bottomNavHeight + dimens.k16, // ✅ dynamic bottom
          child: Column(
            children: [
              /// PROFILE BUTTON
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserProfileDetailsView(
                          profileId: profile.profileId.toString()),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: ColorManager.white,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey.shade300,
                    child: ClipOval(
                      child: profile.profilePicture != null
                          ? Image.network(
                        profile.profilePicture!,
                        fit: BoxFit.cover,
                        width: 48,
                        height: 48,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.person,
                          size: 24,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(
                        Icons.person,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// FAVORITE BUTTON (TOGGLE)
              ActionButton(
                icon: profile.isFavourite == true ? Assets.fav : Assets.favorite,
                imagesColor: profile.isFavourite == true
                    ? ColorManager.primary
                    : ColorManager.white,
                backgroundColor: profile.isFavourite == true
                    ? ColorManager.primary.withOpacity(.3)
                    : ColorManager.white.withOpacity(.3),
                onTap: () {
                  final profileCompleted = viewModel.myProfileCompleted;
                  debugPrint('🔍 profileCompleted on tap: $profileCompleted');
                  if (profileCompleted == null || profileCompleted != 1) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Colors.transparent,
                      builder: (_) => BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: SetUpProfileDialog(),
                        ),
                      ),
                    );
                    return;
                  }

                  final isFav = profile.isFavourite ?? false;
                  final data = {
                    "added_by": login?.data?.user?.name?.trim(),
                    "target_user_id": profile.userId?.trim(),
                    "type": isFav ? "remove" : "add",
                  };
                  viewModel.addToFavouriteList(
                    data,
                    _FavouriteResultHandler(context, profile),
                  );
                },
              ),

              ActionButton(
                icon: Assets.chat,
                onTap: () => print("Chat tapped"),
              ),

              ActionButton(
                icon: Assets.cancel,
                onTap: () => print("Cancel tapped"),
              ),
            ],
          ),
        ),

        /// BOTTOM INFO
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomNavHeight, // ✅ dynamic bottom
          child: Container(
            padding: EdgeInsets.all(dimens.k20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  ColorManager.white.withOpacity(.2),
                ],
              ),
            ),
            child: ProfileInfo(profile: profile),
          ),
        ),
      ],
    );
  }

  Widget _placeholder() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: const Icon(Icons.person, size: 80, color: Colors.grey),
    );
  }
}

/// RESULT HANDLER
class _FavouriteResultHandler implements Result {
  final BuildContext context;
  final Profiles profile;

  _FavouriteResultHandler(this.context, this.profile);

  @override
  void onError(String error) {
    MyToast.showToast(
      message: error,
      typeToast: TypeToast.error,
    );
  }

  @override
  void onSuccess( result) {
    MyToast.showToast(
      message: result,
      typeToast: TypeToast.success,
    );

    // toggle local state
    profile.isFavourite = !(profile.isFavourite ?? false);

    context.read<GetProfileViewModel>().notifyListeners();
  }
}