import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/extensions/extensions.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../application/routes/route_generator.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/otp_verification.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/toast.dart';
import '../auth_view_model.dart';

class VerificationCodeView extends BaseStateFullWidget {
  final String? email;

   VerificationCodeView({super.key, this.email});

  @override
  State<VerificationCodeView> createState() => _VerificationCodeViewState();
}

class _VerificationCodeViewState extends State<VerificationCodeView>
    implements Result<String> {
  late AuthViewModel authVM;

  String? _resolvedEmail;
  String _otpValue = '';
  bool _hasOtpError = false;
  bool _isResendCall = false;
  Timer? _timer;
  int _secondsRemaining = 120;
  bool _isResendEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Prefer route argument, fallback to constructor param
    final routeEmail = ModalRoute.of(context)?.settings.arguments as String?;
    _resolvedEmail = routeEmail ?? widget.email;
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 120;
    _isResendEnabled = false;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          _isResendEnabled = true;
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFB11E24).withOpacity(0.18),
              const Color(0xFFB11E24).withOpacity(0.0),
            ],
          ),
        ),
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return Consumer<AuthViewModel>(
      builder: (context, provider, child) {
        authVM = provider;

        return Column(
          children: [
            SizedBox(height: widget.dimens.k60),

            /// BACK BUTTON
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: ColorManager.primary),
                    Text(
                      "Back",
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: ColorManager.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.dimens.k18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: widget.dimens.k80),

                    Text(
                      StringManager.verificationCode,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: widget.dimens.k32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: widget.dimens.k5),

                    Text(
                      "Enter the OTP sent to your email",
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontSize: widget.dimens.k16,
                        color: ColorManager.textColorSubTitle,
                      ),
                    ),

                    SizedBox(height: widget.dimens.k20),

                    /// OTP FIELD
                    OTPCodeField(
                      hasError: _hasOtpError,
                      onChanged: (value) {          // 👈 har entry/removal pe fire hoga
                        setState(() {
                          _otpValue = value;
                          _hasOtpError = false;     // error clear karo jab user type kare
                        });
                      },
                      onCompleted: (value) {
                        setState(() {
                          _otpValue = value;
                          _hasOtpError = value.length != 6;
                        });
                      },
                    ),

                    SizedBox(height: widget.dimens.k10),

                    /// TIMER + RESEND
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isResendEnabled
                              ? "You can resend code now"
                              : "Resend Code in ${_secondsRemaining ~/ 60}:${(_secondsRemaining % 60).toString().padLeft(2, '0')}",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: ColorManager.textColorSubTitle,
                          ),
                        ),

                        TextButton(
                          onPressed: _isResendEnabled
                              ? () {
                            _isResendCall = true; // 👈 flag set karo
                            authVM.emailVerificationCode(
                              {"email": _resolvedEmail?.trim()},
                              this,
                            );
                            _startTimer();
                          }
                              : null,
                          child: Text(
                            "Resend",
                            style: TextStyle(
                              color: _isResendEnabled
                                  ? ColorManager.primary
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    /// VERIFY BUTTON
                    authVM.apiResponse is Loading
                        ? Loader()
                        : PrimaryButton(
                      onPressed: _otpValue.length == 6
                          ? () {
                        authVM.otpVerificationCode(
                          {
                            "email": _resolvedEmail?.trim(),
                            "otp": _otpValue.trim(),
                          },
                          this,
                        );
                      }
                          : null, // 👈 null = disabled
                      childText: StringManager.verify,
                      color: _otpValue.length == 6
                          ? ColorManager.primary   // ✅ filled → primary color
                          : Colors.grey.shade300,  // ✅ empty → disabled color
                      textStyle: context.textTheme.titleMedium!.copyWith(
                        color: _otpValue.length == 6
                            ? Colors.white
                            : Colors.grey.shade500, // 👈 muted text when disabled
                      ),
                    ),

                    SizedBox(height: widget.dimens.k40),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    MyToast.showToast(message: result, typeToast: TypeToast.success);

    if (_isResendCall) {
      _isResendCall = false; // reset karo
      return; // 👈 navigate mat karo
    }

    widget.navigator.pushNamed(
      RouteManager.rSignUpCreateView,
      object: _resolvedEmail,
    );
  }
}