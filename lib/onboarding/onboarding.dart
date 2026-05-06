
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/color_scheme.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/constants/string_manager.dart';
import '../application/routes/route_generator.dart';
import '../constants/asset_manager.dart';
import '../widgets/primary_button.dart';
class OnboardingView extends BaseStateFullWidget {
  OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}
class _OnboardingViewState extends State<OnboardingView> {

  // @override
  // void initState() {
  //   super.initState();
  //   // Navigate after delay
  //   Timer(const Duration(minutes: 3), () {
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white, // change if needed
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:widget.dimens.k15),
          child: Column(

            children: [
              widget.dimens.k15.verticalBoxPadding,
              Container(
                height: widget.dimens.k350,
                width: size.width,
             
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k20),
                    image: DecorationImage(image: AssetImage(Assets.onboardingImage),fit: BoxFit.cover)
                ),
              ),
              widget.dimens.k15.verticalBoxPadding,
              Text(StringManager.onboardingHint,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize:  widget.dimens.k30,
              ),
                        ),
              widget.dimens.k10.verticalBoxPadding,
              Text(
                "IMB helps you meet your ideal partner smartly, safely, and sincerely. Your forever story starts here.",
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize:  widget.dimens.k16,
                color: ColorManager.textColorSubTitle
              ),
                        ),
              const Spacer(),
              PrimaryButton(
                issquare: true,
                isSafeArea: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Get Started",
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
                   widget.navigator.pushNamed(RouteManager.rLoginView);
                  /*widget.navigator.pushNamedAndRemoveUntil(RouteManager.rSuccessfullyRegisteredView,object: TranforData2(
                      networkType: 'widget',
                      name: 'name.text',
                      iccid: 'iccid.text',
                      msisdn: 'msisdn'));*/
                  //authVM.signInByEmail({"email": email.text.trim(), "pwd": password.text}, this);
                },
              ),
              widget.dimens.k15.verticalBoxPadding,
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: widget.dimens.k13,
                    color: ColorManager.fieldTextColor,
                    fontWeight: FontWeight.w400,

                  ),
                  children: [
                    TextSpan(
                      text: 'By signing in you agree to IMB ',
                      style: TextStyle(
                        fontSize: widget.dimens.k13,
                        color: ColorManager.fieldTextColor,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                    TextSpan(

                      text: 'Terms of Conditions',
                      style: TextStyle(
                          fontSize: widget.dimens.k13,
                          color: ColorManager.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      // Optional click
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     // open terms
                      //   },
                    ),
                     TextSpan(
                      text: ' guideline and our ',
                      style: TextStyle(
                        fontSize: widget.dimens.k13,
                        color: ColorManager.fieldTextColor,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontSize: widget.dimens.k13,
                        color: ColorManager.textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      // Optional click
                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     // open privacy policy
                      //   },
                    ),
                    const TextSpan(
                      text: '.',
                    ),
                  ],
                ),
              ),
              widget.dimens.k20.verticalBoxPadding,
//


            ],
          ),
        ),
      ),
    );
  }
}
