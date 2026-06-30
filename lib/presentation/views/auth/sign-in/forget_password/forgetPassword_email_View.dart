import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/routes/route_generator.dart';
import 'package:provider/provider.dart';

import '../../../../../application/app_theme/color_scheme.dart';
import '../../../../../application/common/enum.dart';
import '../../../../../application/core/result.dart';
import '../../../../../application/helper/validators.dart';
import '../../../../../base/base_widget.dart';
import '../../../../../constants/string_manager.dart';
import '../../../../../widgets/custom_field.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/text_utils.dart';
import '../../../../../widgets/toast.dart';
import '../../auth_mixin.dart';
import '../../auth_view_model.dart';

class ForgetView extends BaseStateFullWidget {
   ForgetView({super.key});

  @override
  State<ForgetView> createState() => _ForgetViewState();
}

class _ForgetViewState extends State<ForgetView>
    with AuthMixin<ForgetView>
    implements Result {

  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextUtils textUtils = TextUtils();
  bool _codeSent = false;

  AuthViewModel get authVM =>
      Provider.of<AuthViewModel>(context, listen: false);

  bool get validate => formKey.currentState?.validate() ?? false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<AuthViewModel>(
        builder: (context, provider, child) {
          return _buildBody(context);
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

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        _background(),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: widget.dimens.k22,
              vertical: widget.dimens.k16,
            ),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.90,
                ),
                child: IntrinsicHeight(
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
                              style:
                              context.textTheme.bodyMedium?.copyWith(
                                color: ColorManager.rejectedText,
                                fontWeight: FontWeight.w500,
                                fontSize: widget.dimens.k14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      widget.dimens.k70.verticalBoxPadding,

                      /// Title
                      Text(
                        StringManager.forgotpassword1,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: widget.dimens.k32,
                          color: ColorManager.textColor,
                        ),
                      ),

                      widget.dimens.k10.verticalBoxPadding,

                      /// Subtitle
                      Text(
                        StringManager.forgotSub,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: widget.dimens.k15,
                          color: ColorManager.textColorSubTitle,
                        ),
                      ),

                      widget.dimens.k30.verticalBoxPadding,

                      /// Form
                      Form(
                        key: formKey,
                        child: Column(
                          children: [

                            CustomField(
                              hintText: "Enter your email",
                              keyboardType:
                              TextInputType.emailAddress,
                              controller: emailController,
                              validator: (input) =>
                                  AppValidators.fieldValidator(input),
                            ),

                          ],
                        ),
                      ),

                      const Spacer(),
                      //
                      // /// Continue With Phone
                      // Center(
                      //   child: GestureDetector(
                      //     onTap: () {
                      //       widget.navigator.pushNamed(
                      //         RouteManager.rContinueWithPhone,
                      //
                      //       );
                      //     },
                      //
                      //     child: Text(
                      //       StringManager.continueWithPhone,
                      //
                      //       style:
                      //       context.textTheme.bodyMedium?.copyWith(
                      //         color: ColorManager.rejectedText,
                      //         fontWeight: FontWeight.w500,
                      //         fontSize: widget.dimens.k14,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      //
                      // widget.dimens.k24.verticalBoxPadding,

                      /// Send Code Button
                      PrimaryButton(
                        childText: _codeSent ? "Please Wait..." : "Send Code",
                        isSafeArea: false,
                        onPressed: _codeSent
                            ? null
                            : () {
                          FocusScope.of(context).unfocus();

                          if (validate) {
                            setState(() => _codeSent = true);

                            authVM.forgetEmailVerificationCode(
                              {
                                "email": emailController.text.trim(),
                              },
                              this,
                            );
                          }
                        },
                      ),

                      widget.dimens.k24.verticalBoxPadding,

                      /// Back To Login
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteManager.rLoginView,
                            );
                          },

                          child: Text(
                            "Back to login",

                            style:
                            context.textTheme.bodyMedium?.copyWith(
                              color: ColorManager.rejectedText,
                              fontWeight: FontWeight.w500,
                              fontSize: widget.dimens.k14,
                            ),
                          ),
                        ),
                      ),

                      widget.dimens.k10.verticalBoxPadding,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
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

    if (emailController.text.trim().isEmpty) {

      MyToast.showToast(
        message: "Email required",
      );

      return;
    }

    widget.navigator.pushNamed(
      RouteManager.rForgetPasswordOTPView,
      object: emailController.text.trim(),
    );
  }
}