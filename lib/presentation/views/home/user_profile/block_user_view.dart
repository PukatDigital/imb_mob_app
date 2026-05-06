import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/widgets/primary_button.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';

import '../../../../widgets/toast.dart';
import '../../auth/auth_mixin.dart';
import '../home_view_model.dart';

class BlockUserView extends BaseStateFullWidget {
  final String userName;
  final String userId;
  BlockUserView({super.key,required this.userName,required this.userId});

  @override
  State<BlockUserView> createState() =>
      _BlockUserViewState();
}

class _BlockUserViewState extends State<BlockUserView>
    with AuthMixin
    implements Result {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Positioned(
          top: size.height * 0.59, // ✅ small value
          left: widget.dimens.k20,
          right: widget.dimens.k20,
          child: Container(
            height: size.height * 0.48,
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: size.height * 0.40,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
            child: _buildContent(context),
          ),
        ),
      ],
    );
  }
  Widget _buildContent(BuildContext context) {
    final viewModel = context.read<GetProfileViewModel>();
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: widget.dimens.k20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.dimens.k15.verticalBoxPadding,
          Center(
            child: Text(
              widget.userName,
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: widget.dimens.k17,
                fontWeight: FontWeight.w600,
                color: ColorManager.textColor,
              ),
            ),
          ),
          widget.dimens.k20.verticalBoxPadding,
          Divider(
            height:  widget.dimens.k2,
            color: ColorManager.addPicture,

          ),
          widget.dimens.k20.verticalBoxPadding,
          _label("They will not be able to find your profile and send you message.",Assets.blockIcon,(){}),
          widget.dimens.k10.verticalBoxPadding,
          _label("They will not be notified if you block them.",Assets.notification,(){}),
          widget.dimens.k10.verticalBoxPadding,
          _label("You can unblock them anytime from settings.",Assets.reportIcon,(){}),
          widget.dimens.k5.verticalBoxPadding,
          Divider(height:  widget.dimens.k2,
            color: ColorManager.addPicture,),
          widget.dimens.k20.verticalBoxPadding,
          Spacer(),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                  childText: 'Reset',
                  issquare: true,
                  color: ColorManager.primary.withOpacity(.2),
                  height: 55,
                  radius: 28,
                  textStyle: context.textTheme.titleMedium!.copyWith(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              widget.dimens.k8.horizontalBoxPadding,

              /// SIGN UP TAB
              Expanded(
                child: PrimaryButton(

                  onPressed: () {
                    final login = widget.iPrefHelper.loginModel;

                    final data = {
                      "added_by": login?.data?.user?.name?.trim(),   // ✅ NOT email
                      "target_user_id": widget.userId,    // already correct
                      "type": "add",
                    };

                    print("REQUEST BODY => $data");

                    viewModel.addToBlockUser(
                      data,this
                    );
                    // setState(() {
                    //   // selectedTab = AuthTab.signup;
                    //
                    // });
                  },
                  childText: 'Apply',
                  issquare: true,
                  color: ColorManager.primary,
                  height: 55,
                  radius: 28,
                  textStyle: context.textTheme.titleMedium!.copyWith(
                    color: ColorManager.white,


                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          widget.dimens.k30.verticalBoxPadding,

          ]
      ),
    );
  }
  Widget _label(String text,image,onTap) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Image.asset(image,height: widget.dimens.k20,width: widget.dimens.k20,),
            widget.dimens.k7.horizontalBoxPadding,
            Expanded(
              child: Text(
                text,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: ColorManager.textColor,
                  fontWeight: FontWeight.w400,
                  fontSize:widget.dimens.k16,
              
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  void onSuccess(result) {
    MyToast.showToast(message: result,
        typeToast: TypeToast.success);
    Navigator.pop(context);
    Navigator.pop(context);



  }
}

