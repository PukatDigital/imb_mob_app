import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../widgets/primary_button.dart';
import '../../../application/routes/route_generator.dart';
class SetUpProfileDialog extends BaseStateFullWidget {

  SetUpProfileDialog({super.key, });

  @override
  State<SetUpProfileDialog> createState() => _SetUpProfileDialogState();
}

class _SetUpProfileDialogState extends State<SetUpProfileDialog> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      child: Padding(
        padding: EdgeInsets.all(widget.dimens.k18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(onPressed: (){
            //       Navigator.pop(context);
            //     }, icon: Icon(Icons.close,color: ColorManager.fieldTextColor,))
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Image.asset(Assets.success,height: widget.dimens.k50,width:widget.dimens.k50,)
            //   ],
            // ),
            Container(
              height: widget.dimens.k150,
              width: size.width,

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k25),
                  image: DecorationImage(image: AssetImage(Assets.onboardingImage),fit: BoxFit.cover)
              ),
            ),
            widget.dimens.k18.verticalBoxPadding,
            Text(
              "Hey Jinwoo, I’m your IMB Match Assistant",
              textAlign: TextAlign.start,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: widget.dimens.k23,
              ),
            ),
            widget.dimens.k5.verticalBoxPadding,
            Text(
              "Help me understand you better — let’s set up your profile.",
              textAlign: TextAlign.start,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: widget.dimens.k16,
                color: ColorManager.textColorSubTitle,
              ),
            ),
            widget.dimens.k18.verticalBoxPadding,

            widget.dimens.k18.verticalBoxPadding,

            PrimaryButton(
              height:widget.dimens.k50 ,
              issquare: true,
              isSafeArea: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Set Up Now",
                    style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize:  widget.dimens.k16,
                        color: ColorManager.white
                    ),

                  ),
                  widget.dimens.k3.horizontalBoxPadding,
                  Image.asset(Assets.arrowUp,height:  widget.dimens.k24,width: widget.dimens.k24 ,),

                ],
              ),
              onPressed: () {
                widget.navigator
                    .pushReplacementNamed(RouteManager.rTSignUpCreationView);
                /*widget.navigator.pushNamedAndRemoveUntil(RouteManager.rSuccessfullyRegisteredView,object: TranforData2(
                    networkType: 'widget',
                    name: 'name.text',
                    iccid: 'iccid.text',
                    msisdn: 'msisdn'));*/
                //authVM.signInByEmail({"email": email.text.trim(), "pwd": password.text}, this);
              },
            ),
            widget.dimens.k10.verticalBoxPadding,
            PrimaryButton(
              height: widget.dimens.k50,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteManager.rBottomBarView,
                      (route) => false, // clears entire stack
                ),
              childText: "Maybe Later",
              textStyle: TextStyle(color: ColorManager.primary),
              issquare: false,
              color: ColorManager.primary.withOpacity(.2),
            ),

          ],
        ),
      ),
    );

  }
}
