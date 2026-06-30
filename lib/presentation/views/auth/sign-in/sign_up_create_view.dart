import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/common/enum.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/sign-in/signup_second_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/sign-in/sing_up_one_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/sign-in/sing_up_third_view.dart';
import 'package:provider/provider.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../application/routes/route_generator.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/toast.dart';
import '../auth_view_model.dart';
import 'login_screen_dialog.dart';
import 'signup_form_data.dart';

class SignUpCreateView extends BaseStateFullWidget {
  final String? email;

  SignUpCreateView({super.key, this.email});

  @override
  State<SignUpCreateView> createState() => _SignUpCreateViewState();
}

class _SignUpCreateViewState extends State<SignUpCreateView>
    implements Result<String> {
  late AuthViewModel authVM;

  final PageController _pageController = PageController();
  int _currentStep = 0;

  String? _resolvedEmail;

  final SignUpFormData _formData = SignUpFormData();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeEmail = ModalRoute.of(context)?.settings.arguments as String?;
    _resolvedEmail = routeEmail ?? widget.email;
  }

  @override
  void dispose() {
    _formData.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      if (!_formData.isStepOneValid) {
        if (_formData.firstNameController.text.trim().isEmpty) {
          MyToast.showToast(message: "Please enter your name");
        } else {
          MyToast.showToast(message: "Please select a gender");
        }
        return;
      }
      _goToPage(1);
    } else if (_currentStep == 1) {
      if (!_formData.isStepTwoValid) {
        if (_formData.selectedQualification == null) {
          MyToast.showToast(message: "Please select your qualification");
        } else if (_formData.selectedCountry == null) {
          MyToast.showToast(message: "Please select your country");
        } else {
          MyToast.showToast(message: "Please select your city");
        }
        return;
      }
      _goToPage(2);
    } else if (_currentStep == 2) {
      if (_formData.passwordController.text.trim().isEmpty) {
        MyToast.showToast(message: "Please enter a password");
        return;
      }
      if (_formData.passwordController.text.trim() !=
          _formData.confirmPasswordController.text.trim()) {
        MyToast.showToast(message: "Passwords do not match");
        return;
      }
      if (_formData.termsAccepted != 1) {
        MyToast.showToast(message: "Please accept the Terms & Conditions");
        return;
      }
      _submitSignUp();
    }
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _submitSignUp() {
    final data = _formData.toJson(_resolvedEmail ?? "");
    authVM.signUpUser(data, this);
  }

  // ✅ Returns true only on step 3 when terms not accepted
  bool get _isSubmitDisabled =>
      _currentStep == 2 && _formData.termsAccepted != 1; // ✅ disable jab tak 1 na ho

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthViewModel>(
      builder: (context, provider, child) {
        authVM = provider;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFB11E24).withOpacity(0.18),
                  const Color(0xFFB11E24).withOpacity(0.08),
                  const Color(0xFFB11E24).withOpacity(0.07),
                  const Color(0xFFB11E24).withOpacity(0.06),
                  const Color(0xFFB11E24).withOpacity(0.05),
                  const Color(0xFFB11E24).withOpacity(0.04),
                  const Color(0xFFB11E24).withOpacity(0.03),
                  const Color(0xFFB11E24).withOpacity(0.02),
                  const Color(0xFFB11E24).withOpacity(0.01),
                  const Color(0xFFB11E24).withOpacity(0.00),
                  const Color(0xFFB11E24).withOpacity(0.00),
                ],
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: widget.dimens.k60),

                /// HEADER
                SizedBox(
                  height: widget.dimens.k50,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            if (_currentStep > 0) {
                              _goToPage(_currentStep - 1);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.arrow_back_ios,
                                    color: ColorManager.primary, size: 18),
                                Text(
                                  "Back",
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: widget.dimens.k20,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            StringManager.createAccount,
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: widget.dimens.k18,
                            ),
                          ),
                          Text(
                            "Step ${_currentStep + 1} of 3",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: ColorManager.fieldTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// PROGRESS BAR
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.dimens.k18),
                  child: Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 4,
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? ColorManager.primary
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                /// PAGES
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _currentStep = index);
                    },
                    children: [
                      StepOneView(formData: _formData),
                      StepTwoView(formData: _formData),
                      StepThreeView(
                        formData: _formData,
                        onTermsChanged: () => setState(() {}), // ✅ rebuild on checkbox toggle
                      ),
                    ],
                  ),
                ),

                /// NEXT / SUBMIT BUTTON
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    widget.dimens.k18,
                    1,
                    widget.dimens.k18,
                    widget.dimens.k25,
                  ),
                  child: authVM.apiResponse is Loading
                      ?  Loader()
                      : PrimaryButton(
                    onPressed: _isSubmitDisabled ? null : _nextStep, // ✅ disabled when terms not accepted
                    childText: _currentStep == 2 ? "Submit" : "Next",
                    issquare: false,
                    color: _isSubmitDisabled
                        ? Colors.grey // ✅ grey when disabled
                        : ColorManager.primary,
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
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    _formData.reset();
    _showVerificationDialog();

    Future.delayed(const Duration(seconds: 3), () {        
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteManager.rLoginView ,
            (route) => false,
      );
    });
  }

  void _showVerificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent, // ✅ remove default dark barrier
      builder: (_) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: VerificationDialog(),
        ),
      ),
    );
  }
}