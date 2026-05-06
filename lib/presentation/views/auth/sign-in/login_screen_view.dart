import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:provider/provider.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/result.dart';
import '../../../../application/helper/validators.dart';
import '../../../../application/network/result.dart';
import '../../../../application/routes/route_generator.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../constants/string_manager.dart';
import '../../../../data/models/login_model/Auth_login_model.dart';
import '../../../../widgets/custom_field.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/toast.dart';
import '../auth_mixin.dart';
import '../auth_view_model.dart';
class LoginFormView extends BaseStateFullWidget {
   LoginFormView({super.key});
  @override
  State<LoginFormView> createState() => _LoginFormViewState();
}
class _LoginFormViewState extends State<LoginFormView>
    with AuthMixin<LoginFormView>  implements Result<LoginModel>{
  @override
  Widget build(BuildContext context) {
     return Consumer <AuthViewModel> (
      builder: (context, provider, child){
        authVM = provider;
        return Form(
          key: formKey, // ✅ mixin formKey
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.dimens.k10.verticalBoxPadding,
              CustomField(
                hintText: StringManager.username,
                keyboardType: TextInputType.emailAddress,
                controller: email, // ✅ from mixin
                validator: (input) =>
                    AppValidators.fieldValidator(input),
              ),
              widget.dimens.k10.verticalBoxPadding,
              CustomField(
                controller: password, // ✅ from mixin
                hintText: StringManager.password,
                obscureText: !passVisibility, // ✅ FIXED
                suffixIcon: Icon(
                  passVisibility
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: ColorManager.fieldTextColor,
                ),
                suffixIconCallBack: () {
                  setState(() {
                    passVisibility = !passVisibility;
                  });
                },
                validator: (input) =>
                    AppValidators.fieldValidator(input),
                maxLines: 1,
              ),
              widget.dimens.k10.verticalBoxPadding,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: remember,
                        checkColor: ColorManager.primary, // tick color
                        fillColor: WidgetStateProperty.all(Colors.white), // always white background
                        side: WidgetStateBorderSide.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return BorderSide(color: ColorManager.primary, width: 1.5); // selected border
                          }
                          return BorderSide(color: ColorManager.textColor, width: 1.5); // normal border
                        }),
                        onChanged: (val) {
                          setState(() {
                            remember = val ?? false;
                          });
                        },
                      ),
                      Text(
                        'Save login info',
                        style: context.textTheme.titleMedium?.copyWith(
                            fontSize:  widget.dimens.k16,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.fieldTextColor

                        ),
                      ),

                    ],
                  ),
                  widget.dimens.k15.verticalBoxPadding,
                  GestureDetector(
                    onTap: () {
                      // widget.navigator.pushNamed(RouteManager.rForgetView);
                    },
                    child: Text(
                      StringManager.forgetPassword,
                      style: context.textTheme.titleMedium?.copyWith(
                          fontSize:  widget.dimens.k16,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.fieldTextColor

                      ),
                    ),
                  ),
                ],
              ),
              widget.dimens.k10.verticalBoxPadding,
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorManager.fieldTextColor.withOpacity(0.5),
                      thickness: 1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widget.dimens.k8),
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
              widget.dimens.k10.verticalBoxPadding,
              Container(
                height:widget.dimens.k50 ,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k10),
                  color: ColorManager.liteGrey,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(Assets.loginWithGoogle,height: widget.dimens.k25,width: widget.dimens.k25,),
                    widget.dimens.k10.horizontalBoxPadding,
                    Text(
                      StringManager.loginWithGoogle,
                      style: context.textTheme.titleMedium?.copyWith(
                          fontSize:  widget.dimens.k16,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.fieldTextColor
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              authVM.apiResponse is Loading
                  ? Loader()
                  :
              PrimaryButton(

                childText: 'Login',
                textStyle: context.textTheme.bodyMedium?.copyWith(
                  fontSize: widget.dimens.k16,
                  fontWeight: FontWeight.w500,
                  color: ColorManager.white,
                ),
                issquare: true,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Get FCM token (async)
                    //final fcmToken = await FirebaseNotificationService.getCurrentToken();

                    final loginData = {
                      "email": email.text.trim(),
                      "password": password.text.trim(),
                      // "fcm_token": fcmToken.isNotEmpty ? fcmToken : "",
                    };

                    //print('Login with FCM token: $fcmToken');
                    authVM.signInByEmail(loginData, this);
                  }
                  //widget.navigator.pushNamedAndRemoveUntil(RouteManager.rBottomBarView);
                  // if (validate) {
                  //
                  //   // authVM.login(email.text, password.text);
                  // }
                },
              ),
              widget.dimens.k40.verticalBoxPadding,
            ],
          ),
        );
      },
    );
  }
  @override
  onError(String error) {
    MyToast.showToast(message: error);
  }
  @override
  onSuccess(LoginModel result) {        // ✅ was (result) — now explicitly typed
    final userData = result.data;

    if (userData?.success == true && userData?.user != null) {
      widget.iPrefHelper.saveLoginModel(result);

      MyToast.showToast(
        message: result.data?.message ?? "" ,
        typeToast: TypeToast.success,

      );

      widget.navigator.pushNamedAndRemoveUntil(RouteManager.rBottomBarView);

      print('✅ Logged in as: ${userData?.user?.fullName}');
    } else {
      MyToast.showToast(
        message: result.data?.message ?? "Invalid login response",
        typeToast: TypeToast.error,
      );
    }
  }
}
