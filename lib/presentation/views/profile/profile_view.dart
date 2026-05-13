import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/profile/profile_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../application/common/log.dart';
import '../../../application/routes/route_generator.dart';
import '../../../constants/asset_manager.dart';
import '../auth/auth_mixin.dart';
import '../auth/auth_view_model.dart';
import 'covered_profile.dart';
class ProfileScreen extends BaseStateFullWidget {
   ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> with AuthMixin
    implements Result<String> {
  late GetPersonalProfileViewModel profileData;
  bool _pushNotificationEnabled = true;
  late final loginModel;


  @override
  void initState() {
    super.initState();

    loginModel = widget.iPrefHelper.loginModel;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      context.read<GetPersonalProfileViewModel>().getAllPersonalProfileDetails(
        this,
        profileId: loginModel?.data?.user?.name, // ✅ FIXED
      );
    });
  }


  final int _currentIndex = 0;
  // final List<String> coverImages = [
  //   Assets.home1,
  //   Assets.home2,
  //   Assets.home3,
  //   Assets.home2,
  // ];
  @override
  Widget build(BuildContext context) {

    return Consumer<GetPersonalProfileViewModel>(
      builder: (_, provider, __) {

        profileData = provider;
        return Scaffold(
          backgroundColor: ColorManager.liteWhite,
          body: _mainContent(),
        );
      },
    );
  }
  Widget _mainContent() {
    final size = MediaQuery.of(context).size;
    List<String> getProfileImages() {
      final attachments = profileData.profileDetailsModel.data?.attachments;

      List<String> apiImages = [
        attachments?.attach1 ?? "",
        attachments?.attach2 ?? "",
        attachments?.attach3 ?? "",
        attachments?.attach4 ?? "",
      ];

      // remove empty values
      apiImages = apiImages.where((e) => e.isNotEmpty).toList();

      // 👉 return API images OR empty list
      return apiImages;
    }
    final images = getProfileImages();
    return Padding(
      padding: EdgeInsets.all(widget.dimens.k15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            widget.dimens.k50.verticalBoxPadding,
            _header(),
            widget.dimens.k15.verticalBoxPadding,

            ProfileCoverCard(
              image: profileData.profileDetailsModel.data?.profilePicture??"",
              coverImages: getProfileImages(),
              name: profileData.profileDetailsModel.data?.profileName ?? "",
              email: profileData.profileDetailsModel.data?.email ?? "",
              reach: "${profileData.profileDetailsModel.data?.profileCompleted ?? 0}%",
              impressions: profileData.profileDetailsModel.data?.totalFavouriteProfiles?.toString() ?? "0",
              credit: profileData.profileDetailsModel.data?.noOfTimesAddedAsFavourite?.toString() ?? "0",
              onProfileTap: () {
                widget.navigator.pushNamed(
                  RouteManager.rProfileDetailsView,
                      object: profileData.profileDetailsModel.data, // ✅ data pass karo
                );
              },
            ),
            // ProfileCoverCard(
            //   coverImages: coverImages,
            //   name: "Name",
            //   email: "email",
            //   reach: "67%",
            //   impressions: "7.6k",
            //   credit: "2.8",
            //   onProfileTap: () {
            //      widget.navigator.pushNamed(RouteManager.rProfileDetailsView);
            //     // 👇 navigate to another screen
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(
            //     //     builder: (_) => const ProfileDetailScreen(),
            //     //   ),
            //     // );
            //   },
            // ),
            widget.dimens.k15.verticalBoxPadding,
            Container(
              width: size.width,
             padding: EdgeInsets.symmetric(vertical:  widget.dimens.k20,horizontal:  widget.dimens.k15),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(widget.dimens.k25),
               color: ColorManager.containerColor,
             ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         "Upgrade to Premium ",
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorManager.white,
                          ),
                        ),
                        widget.dimens.k10.verticalBoxPadding,
                        Text(
                          "Boost your visibility, and unlock all exclusive features.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: ColorManager.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.navigator.pushNamed(RouteManager.rPlanView);

                    },
                    child: Container(
                      height: 40,
                      width:  widget.dimens.k100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFFE3B23C),
                            Color(0xFFE5C26D),
                            Color(0xFFE3B23C),
                            Color(0xFFE5C26D),
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "View Plans",
                          style: TextStyle(
                            color:ColorManager.textColor,
                            fontWeight: FontWeight.w500,
                            fontSize:  widget.dimens.k14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.dimens.k15.verticalBoxPadding,
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical:  widget.dimens.k20,horizontal:  widget.dimens.k15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.dimens.k25),
                color: ColorManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notifications",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.fieldTextColor,
        
                    ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Assets.notification,
                        height: widget.dimens.k20,
                        width: widget.dimens.k20,
                      ),
                      widget.dimens.k5.horizontalBoxPadding,
                      Text(
                        "Push Notifications",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorManager.textColor,
                          fontSize: widget.dimens.k15,
                        ),
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                    value: _pushNotificationEnabled,
                    activeTrackColor: ColorManager.primary,          // ON track + thumb
                    inactiveTrackColor: ColorManager.dropDownBroder,    // OFF track
                    onChanged: (value) {
                      setState(() {
                        _pushNotificationEnabled = value;
                      });
                      d(value ? "Push Notifications ON" : "OFF");
                    },
                  )
                ],
              ),
              ],
              ),
            ),
            widget.dimens.k15.verticalBoxPadding,
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical:  widget.dimens.k20,horizontal:  widget.dimens.k15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.dimens.k25),
                color: ColorManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legal",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.fieldTextColor,
        
                    ),
                  ),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){},Assets.getHelp,"Get help"),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){},Assets.report,"Report a Problem"),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){},Assets.privacyPolicy,"Privacy Policy"),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){},Assets.termsCondition,"Terms & Conditions"),
        
                ],
              ),
            ),
            widget.dimens.k15.verticalBoxPadding,
            Container(
              width: size.width,
              padding: EdgeInsets.symmetric(vertical:  widget.dimens.k20,horizontal:  widget.dimens.k15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.dimens.k25),
                color: ColorManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account",
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorManager.fieldTextColor,
        
                    ),
                  ),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){
                    widget.navigator.pushNamed(RouteManager.rLinkedDeviceView,);
                  },Assets.linked,"Accounts Linked"),
                  widget.dimens.k20.verticalBoxPadding,
                  // legalCard((){
                  //   widget.navigator.pushNamed(RouteManager.rPaymentHistoryView,);
                  // },Assets.linked,"Payment History"),
                  // widget.dimens.k20.verticalBoxPadding,
                  legalCard((){
                    widget.navigator.pushNamed(RouteManager.rBlockListView,);
                  },Assets.blockIcon,"Blocked Account"),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){},Assets.deleteIcon,"Delete Account"),
                  widget.dimens.k20.verticalBoxPadding,
                  legalCard((){

                    widget.iPrefHelper.clear();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteManager.rLoginView,
                          (route) => false,
                    );
                  },Assets.logOut,"Log Out"),
               
        
                ],
              ),
            ),
            widget.dimens.k80.verticalBoxPadding,
          ],
        ),
      ),
    );
  }
  Widget _header() {
    return Center(
      child: Text(
        "Me",
        style: TextStyle(
          fontSize: widget.dimens.k18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result,
    typeToast: TypeToast.success);
  }

  legalCard(onTap, image, text) {
    return  GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            image,
            height: widget.dimens.k20,
            width: widget.dimens.k20,
            color: ColorManager.primary,
          ),
          widget.dimens.k5.horizontalBoxPadding,
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.textColor,
              fontSize: widget.dimens.k15,
            ),
          ),
        ],
      ),
    );
  }
}
