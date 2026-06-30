import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../widgets/primary_button.dart';
import 'login_view.dart';
class VerificationDialog extends BaseStateFullWidget {

   VerificationDialog({super.key, });

  @override
  State<VerificationDialog> createState() => _VerificationDialogState();
}
class _VerificationDialogState extends State<VerificationDialog> {
  String? selectedOption;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(widget.dimens.k18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     IconButton(onPressed: (){
            //       Navigator.pop(context);
            //     }, icon: Icon(Icons.close,color: ColorManager.fieldTextColor,))
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(Assets.success,height: widget.dimens.k50,width:widget.dimens.k50,)
              ],
            ),
            widget.dimens.k18.verticalBoxPadding,
            Center(
              child: Text(
                "Account created successfully",
                textAlign: TextAlign.center,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: widget.dimens.k22,
                ),
              ),
            ),
            widget.dimens.k5.verticalBoxPadding,
            Text(
              "Please log in to continue.",
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: widget.dimens.k16,
                color: ColorManager.textColorSubTitle,
              ),
            ),
            widget.dimens.k18.verticalBoxPadding,
            widget.dimens.k18.verticalBoxPadding,
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginView(initialTab: AuthTab.login),
                  ),
                );
              },
              childText: "Go to login",
              issquare: false,
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}
