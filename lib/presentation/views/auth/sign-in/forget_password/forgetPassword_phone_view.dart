import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../application/app_theme/color_scheme.dart';
import '../../../../../application/helper/validators.dart';
import '../../../../../application/routes/route_generator.dart';
import '../../../../../constants/string_manager.dart';
import '../../../../../widgets/custom_field.dart';
import '../../../../../widgets/custom_minidropdown.dart';
import '../../../../../widgets/primary_button.dart';
import '../../../../../widgets/text_utils.dart';
import '../../auth_view_model.dart';
class ContinueWithPhoneNumber extends BaseStateFullWidget {
   ContinueWithPhoneNumber({super.key});

  @override
  State<ContinueWithPhoneNumber> createState() => _ContinueWithPhoneNumberState();
}

class _ContinueWithPhoneNumberState extends State<ContinueWithPhoneNumber> {
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextUtils textUtils = TextUtils();
  /// Dummy Country List
  /// Dummy Country List
  final List<String> countryCodes = [
    "🇵🇰 +92",
    "🇮🇳 +91",
    "🇺🇸 +1",
    "🇬🇧 +44",
  ];

  String? selectedCountry;
  @override
  void initState() {
    super.initState();

    selectedCountry = countryCodes.first;
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
                              _background(),
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

                              /// Description
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    /// Mini Country Dropdown — fixed width, self-contained
                                    SizedBox(
                                      width: 95, // just enough for "+92 ▾"
                                      child: MiniDropDown<String>(
                                        list: countryCodes,
                                        selectedItem: selectedCountry,
                                        hintText: "+92",
                                        onChanged: (val) {
                                          setState(() => selectedCountry = val!);
                                        },
                                      ),
                                    ),

                                    widget.dimens.k10.horizontalBoxPadding,

                                    /// Phone Number Field — takes all remaining space
                                    Expanded(
                                      child: CustomField(
                                        hintText: "Enter your phone number",
                                        keyboardType: TextInputType.phone,
                                        controller: phoneController,
                                        validator: (input) => AppValidators.fieldValidator(input),
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              const Spacer(),

                              /// Continue With Phone
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, RouteManager.rForgotPassword);
                                  },
                                  child: Text(
                                    StringManager.continueWithemail ,
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: ColorManager.rejectedText,
                                      fontWeight: FontWeight.w500,
                                      fontSize: widget.dimens.k14,
                                    ),
                                  ),
                                ),
                              ),

                              widget.dimens.k24.verticalBoxPadding,

                              /// Send Code Button
                              PrimaryButton(
                                childText: "Send Code",
                                isSafeArea: false,
                                onPressed: () {

                                  /// Dummy Navigation / Dummy API
                                  // if (formKey.currentState?.validate() ?? false) {
                                  //
                                  //   /// temporary dummy flow
                                  //   Navigator.pushNamed(
                                  //     context,
                                  //     "/otpView",
                                  //     arguments: {
                                  //       "email": phoneController.text.trim(),
                                  //     },
                                  //   );
                                  // }
                                },
                              ),

                              widget.dimens.k24.verticalBoxPadding,

                              /// Back To Login
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, RouteManager.rLoginView);
                                  },
                                  child: Text(
                                    "Back to login",
                                    style: context.textTheme.bodyMedium?.copyWith(
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
                      )))   ),]
    );
  }
}
