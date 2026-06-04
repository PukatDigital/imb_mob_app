import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/routes/route_generator.dart';
import 'package:provider/provider.dart';

import '../../../../../application/app_theme/color_scheme.dart';
import '../../../../../application/app_theme/text_themes.dart';
import '../../../../../application/common/enum.dart';
import '../../../../../application/core/result.dart';
import '../../../../../base/base_widget.dart';
import '../../../../../constants/asset_manager.dart';
import '../../../../../widgets/custom_field.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/toast.dart';
import '../../auth_view_model.dart';

class CreateNewPasswordView extends BaseStateFullWidget {
  CreateNewPasswordView({super.key});

  @override
  State<CreateNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView>
    implements Result {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthViewModel>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              /// Background
              _background(),

              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.dimens.k22,
                    vertical: widget.dimens.k16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Back Button
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios,
                              size: widget.dimens.k16,
                              color: ColorManager.rejectedText,
                            ),

                            Text(
                              "Back",
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: ColorManager.rejectedText,
                                fontWeight: FontWeight.w400,
                                fontSize: widget.dimens.k14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      widget.dimens.k50.verticalBoxPadding,

                      /// Main Card
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.dimens.k2,
                              vertical: widget.dimens.k15,
                            ),

                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height * 0.75,
                              ),
                              child: IntrinsicHeight(
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// Title
                                      Text(
                                        "Create new password",
                                        style: context.textTheme.titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                              fontSize: widget.dimens.k32,
                                              color: ColorManager.textColor,
                                            ),
                                      ),

                                      widget.dimens.k10.verticalBoxPadding,

                                      /// Subtitle
                                      Text(
                                        "Set a new password for your account.",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: widget.dimens.k15,
                                              color:
                                                  ColorManager.textColorSubTitle,
                                            ),
                                      ),

                                      widget.dimens.k30.verticalBoxPadding,

                                      /// Password Label
                                      Text(
                                        "Password",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),

                                      widget.dimens.k8.verticalBoxPadding,

                                      /// Password Field
                                      CustomField(
                                        hintText: "Enter password",
                                        controller: passwordController,
                                        obscureText: obscurePassword,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              obscurePassword =
                                                  !obscurePassword;
                                            });
                                          },
                                          child: Icon(
                                            obscurePassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Password is required";
                                          }

                                          if (value.length < 8) {
                                            return "Password must be at least 8 characters";
                                          }

                                          return null;
                                        },
                                      ),

                                      widget.dimens.k20.verticalBoxPadding,

                                      /// Confirm Password Label
                                      Text(
                                        "Confirm Password",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),

                                      widget.dimens.k8.verticalBoxPadding,

                                      /// Confirm Password Field
                                      CustomField(
                                        hintText: "Confirm Password",
                                        controller: confirmPasswordController,
                                        obscureText: obscureConfirmPassword,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              obscureConfirmPassword =
                                                  !obscureConfirmPassword;
                                            });
                                          },
                                          child: Icon(
                                            obscureConfirmPassword
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Confirm password is required";
                                          }

                                          if (value !=
                                              passwordController.text.trim()) {
                                            return "Passwords do not match";
                                          }

                                          return null;
                                        },
                                      ),

                                      const Spacer(),

                                      /// Button
                                      PrimaryButton(
                                        childText: "Update Password",
                                        isSafeArea: false,
                                        onPressed: () {

                                          // if (formKey.currentState
                                          //         ?.validate() ??
                                          //     false) {
                                          //   /// Dummy Success
                                          //   onSuccess(
                                          //     "Password updated successfully",
                                          //   );
                                          }
                                        ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _background() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFB11E24).withOpacity(.18),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
  void showPasswordResetDailogue(BuildContext context, dynamic? dimens) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dimens.k24),
          ),
          insetPadding: EdgeInsets.symmetric(
            horizontal: dimens.k20,
          ),
          child: Padding(
            padding: EdgeInsets.all(dimens.k24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: dimens.k20,
                      color: Colors.grey,
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(dimens.k10),
                  decoration: const BoxDecoration(

                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    Assets.success, // ✅ already correct
                    height: dimens.k40,
                    width: dimens.k40,
                    fit: BoxFit.contain,
                  ),
                ),  // closes Container (green circle)

                SizedBox(height: dimens.k20),  // ✅

                Text(
                  'Password updated\n successfully 🎉',  // ✅ fixed \n too
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: dimens.k24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),

                SizedBox(height: dimens.k12),  // ✅

                Text(
                  'You can now log in with your new \n password.',  // ✅ fixed \n
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: dimens.k15,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                SizedBox(height: dimens.k28),  // ✅

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: ColorManager.rejectedText,
                      padding: EdgeInsets.symmetric(
                        vertical: dimens.k16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(dimens.k40),
                      ),
                    ),
                    onPressed: () {
                     Navigator.pushReplacementNamed(context, RouteManager.rLoginView);
                    },
                    child: Text(
                      'Go to Login',
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
          ),
        );
      },
    );
  }

  @override
  onError(String error) {
    MyToast.showToast(message: error, typeToast: TypeToast.error);
  }

  @override
  onSuccess(result) {
    MyToast.showToast(message: result.toString(), typeToast: TypeToast.success);
    showPasswordResetDailogue(context, widget.dimens);
    Navigator.pop(context);
  }
}
