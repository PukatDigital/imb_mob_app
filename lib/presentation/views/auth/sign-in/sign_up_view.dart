import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/result.dart';
import '../../../../application/helper/validators.dart';
import '../../../../application/routes/route_generator.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_field.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/toast.dart';
import '../auth_mixin.dart';
import '../auth_view_model.dart';

class SignUpFormView extends BaseStateFullWidget {
   SignUpFormView({super.key});

  @override
  State<SignUpFormView> createState() => _SignUpFormViewState();
}

class _SignUpFormViewState extends State<SignUpFormView>
    with AuthMixin<SignUpFormView>
    implements Result {

  @override
  void initState() {
    super.initState();
    authVM = AuthViewModel(); // ✅ make sure VM initialized
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Form(
      key: formKey, // ✅ FIXED (using mixin formKey)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          widget.dimens.k15.verticalBoxPadding,

          /// 🔹 EMAIL / USERNAME FIELD
          CustomField(
            hintText: StringManager.username,
            keyboardType: TextInputType.emailAddress,
            controller: email,
            validator: (input) => AppValidators.fieldValidator(input),
          ),
         //const Spacer(),

         SizedBox(height: size.height * .20),

          /// 🔹 SIGN UP BUTTON
          PrimaryButton(
            childText: 'Sign Up',
            textStyle: context.textTheme.bodyMedium?.copyWith(
              fontSize: widget.dimens.k16,
              fontWeight: FontWeight.w500,
              color: ColorManager.white,
            ),
            issquare: true,
            onPressed: () {
              if (validate) {
                authVM.emailVerificationCode(
                  {"email": email.text.trim()},
                  this,
                );
              }
            },
          ),
          widget.dimens.k15.verticalBoxPadding,
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: ColorManager.fieldTextColor.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(horizontal: widget.dimens.k8),
                child: Text(
                  'or',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: widget.dimens.k16,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.fieldTextColor,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: ColorManager.fieldTextColor.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
            ],
          ),

          widget.dimens.k15.verticalBoxPadding,

          /// 🔹 GOOGLE LOGIN BUTTON (UI ONLY)
          Container(
            height: widget.dimens.k50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.dimens.k10),
              color: ColorManager.liteGrey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.loginWithGoogle,
                  height: widget.dimens.k25,
                  width: widget.dimens.k25,
                ),
                widget.dimens.k10.horizontalBoxPadding,
                Text(
                  StringManager.loginWithGoogle,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: widget.dimens.k16,
                    fontWeight: FontWeight.w500,
                    color: ColorManager.fieldTextColor,
                  ),
                ),
              ],
            ),
          ),

          widget.dimens.k40.verticalBoxPadding,
        ],
      ),
    );
  }
  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  void onSuccess(result) {
    MyToast.showToast(
      message: result,
      typeToast: TypeToast.success,
    );

    if (email.text.trim().isEmpty) {
      MyToast.showToast(message: "Email required");
      return;
    }

    widget.navigator.pushNamed(
      RouteManager.rVerificationCodeView,
      object: email.text.trim(), // or arguments depending on your nav system
    );
  }
}