import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/sign-in/sign_up_view.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/primary_button.dart';
import '../auth_view_model.dart';
import 'login_screen_view.dart';
class LoginView extends BaseStateFullWidget {
  final AuthTab initialTab;
  LoginView({super.key,this.initialTab = AuthTab.login});
  @override
  State<LoginView> createState() => _LoginViewState();
}
enum AuthTab { login, signup }
class _LoginViewState extends State<LoginView> {
  AuthTab selectedTab = AuthTab.login;
  // String phoneNumber = '';
  // final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;
  late AuthViewModel authVM;
  @override
  void initState() {
    super.initState();
    selectedTab = widget.initialTab; // initialize from passed value
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
            child: _body())
    );
  }
  Widget _body() {
    var size = MediaQuery.sizeOf(context);
    return Consumer <AuthViewModel> (
      builder: (context, provider, child){
        authVM = provider;
        return  Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widget.dimens.k70.verticalBoxPadding,
                    CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius:widget.dimens.k45 ,
                        backgroundImage: AssetImage(Assets.imbIcon,)),
                    widget.dimens.k10.verticalBoxPadding,
                    Text(StringManager.loginHint,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize:  widget.dimens.k30,
                      ),
                    ),
                    widget.dimens.k5.verticalBoxPadding,
                    Text(
                      StringManager.loginSubHint,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize:  widget.dimens.k16,
                          color: ColorManager.textColorSubTitle
                      ),
                    ),
                  ],
                ),
                widget.dimens.k15.verticalBoxPadding,
                Container(
                  width: size.width,
                  height: widget.dimens.k60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(widget.dimens.k15),
                    color: ColorManager.loginContainer,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(widget.dimens.k4),
                    child:
                    Row(
                      children: [

                        /// LOGIN TAB
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () {
                              setState(() {
                                selectedTab = AuthTab.login;

                              });


                            },
                            childText: 'Login',
                            issquare: true,
                            color: selectedTab == AuthTab.login
                                ? ColorManager.white
                                : Colors.transparent,
                            height: 50,
                            radius: 10,
                            textStyle: context.textTheme.bodySmall!.copyWith(
                              color: selectedTab == AuthTab.login
                                  ?    ColorManager.textColor
                                  :   ColorManager.fieldTextColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        widget.dimens.k8.horizontalBoxPadding,

                        /// SIGN UP TAB
                        Expanded(
                          child: PrimaryButton(
                            onPressed: () {
                              setState(() {
                                selectedTab = AuthTab.signup;

                              });
                            },
                            childText: 'Sign up',
                            issquare: true,
                            color: selectedTab == AuthTab.signup
                                ? ColorManager.white
                                : Colors.transparent,
                            height: 50,
                            radius: 10,
                            textStyle: context.textTheme.bodySmall!.copyWith(
                              color: selectedTab == AuthTab.signup
                                  ?    ColorManager.textColor
                                  :   ColorManager.fieldTextColor,


                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(                        // ✅ replace Expanded with SizedBox
                  height: size.height * 0.65,   // adjust this value to fit your layout
                  child: selectedTab == AuthTab.login
                      ? LoginFormView()
                      : SignUpFormView(),
                ),

              ],
            ).padding(
              EdgeInsets.symmetric(
                horizontal: widget.dimens.k20,

              ),
            ),
          ),
        );
      },
    );
  }
}

