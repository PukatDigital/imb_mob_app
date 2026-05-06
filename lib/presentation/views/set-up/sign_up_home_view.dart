import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/partner_prefrance_view.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/sign_up_view_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/tell_about_family.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/tell_about_your_self.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/common/enum.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../widgets/primary_button.dart';
import '../../../../widgets/text_utils.dart';
import '../../../../widgets/toast.dart';
import '../../../application/network/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../auth/auth_mixin.dart';
import '../auth/auth_view_model.dart';
import '../auth/sign-in/login_screen_dialog.dart';
import 'add_your_pictures.dart';
import 'bio_other_details.dart';
import 'education_profession_view.dart';
import 'life_style_interest.dart';
class SignUpCreationView extends BaseStateFullWidget {
  SignUpCreationView({super.key});
  @override
  State<SignUpCreationView> createState() => _SignUpCreationViewState();
}
class _SignUpCreationViewState extends State<SignUpCreationView>
    with AuthMixin
    implements Result {
  TextUtils textUtils = TextUtils();
  late SignUpViewModel signUpVM;
  late SetUpProfileViewModel newDocVM;
  final PageController _pageController = PageController();
  int _currentStep = 0;
  // ── Page Keys ────────────────────────────────────────────────────────────
  final GlobalKey<TellAboutYourSelfViewState>   _page1Key = GlobalKey();
  final GlobalKey<TellAboutYourFamilyViewState> _page2Key = GlobalKey();
  final GlobalKey<EducationProfessionViewState> _page3Key = GlobalKey();
  final GlobalKey<LifStyleInterestViewState>    _page4Key = GlobalKey();
  final GlobalKey<PartnerPreferencesViewState>  _page5Key = GlobalKey();
  final GlobalKey<AddYourPicturesState>         _page6Key = GlobalKey();
  final GlobalKey<BioAndOtherDetailsViewState>  _page7Key = GlobalKey();
  // ── Save current step to prefs ───────────────────────────────────────────
  // void _saveCurrentStep() {
  //   switch (_currentStep) {
  //     case 0: _page1Key.currentState?.saveSetupProfileStep(); break;
  //     case 1: _page2Key.currentState?.saveSetupProfileStep(); break;
  //     case 2: _page3Key.currentState?.saveSetupProfileStep(); break;
  //     case 3: _page4Key.currentState?.saveSetupProfileStep(); break;
  //     case 4: _page5Key.currentState?.saveSetupProfileStep(); break;
  //     case 5: _page6Key.currentState?.saveSetupProfileStep(); break;
  //     case 6: _page7Key.currentState?.saveSetupProfileStep(); break;
  //   }
  // }
  Future<String> _fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    final ext   = file.path.split('.').last.toLowerCase();
    String mime = 'image/jpeg';
    if (ext == 'png')  mime = 'image/png';
    if (ext == 'webp') mime = 'image/webp';
    return 'data:$mime;base64,${base64Encode(bytes)}';
  }
  Future<void> _saveCurrentStep() async {
    switch (_currentStep) {
      case 0: _page1Key.currentState?.saveSetupProfileStep(); break;
      case 1: _page2Key.currentState?.saveSetupProfileStep(); break;
      case 2: _page3Key.currentState?.saveSetupProfileStep(); break;
      case 3: _page4Key.currentState?.saveSetupProfileStep(); break;
      case 4: _page5Key.currentState?.saveSetupProfileStep(); break;
      case 5:
      // ✅ Page 6 async hai — await zaroor karo
        await _page6Key.currentState?.saveSetupProfileStep();
        break;
      case 6: _page7Key.currentState?.saveSetupProfileStep(); break;
    }
  }
  // ── Build final payload from prefs ───────────────────────────────────────
  // Map<String, dynamic> _buildSubmitPayload() {
  //   final pref   = context.read<IPrefHelper>();
  //   final saved  = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();
  //   // user_id — logged in user ki email / id
  //   final userId = pref.loginModel?.data?.user?.email ?? '';
  //   return {
  //     "data": {
  //       "user_id":                    userId,
  //       "profile_name":               saved.profileName ?? '',
  //       "last_name":                  saved.lastName ?? '',
  //       "gender":                     saved.gender ?? '',
  //       "date_of_birth":              saved.dateOfBirth ?? '',
  //       "mother_tongue":              saved.motherTongue ?? '',
  //       "caste":                      saved.caste ?? '',
  //       "hight":                      saved.height ?? '',
  //       "weight":                     saved.weight ?? '',
  //       "material_status":            saved.materialStatus ?? '',
  //       "country":                    saved.country ?? '',
  //       "ethnicity":                  saved.ethnicity ?? '',
  //       "nationality":                saved.nationality ?? '',
  //       "religion":                   saved.religion ?? '',
  //       "belongs_to":                 saved.belongsTo ?? '',
  //       "religious_practice":         saved.religiousPractice ?? '',
  //       "zodiac_sign":                saved.zodiacSign ?? '',
  //       "father_name":                saved.fatherName ?? '',
  //       "father_occupation":          saved.fatherOccupation ?? '',
  //       "family_values":              saved.familyValues ?? '',
  //       "living_arrangement":         saved.livingArrangement ?? '',
  //       "married":                    saved.married ?? '',
  //       "unmarried":                  saved.unmarried ?? '',
  //       "house_size":                 saved.houseSize ?? '',
  //       "area_society":               saved.areaSociety ?? '',
  //       "can_move_abroad_for_marriage": saved.canMoveAbroadForMarriage ?? '',
  //       "have_childern":              saved.haveChildren ?? '',
  //       "other_family_details":       saved.otherFamilyDetails ?? '',
  //       "qualification":              saved.qualification ?? '',
  //       "name_institution":           saved.nameInstitution ?? '',
  //       "profession":                 saved.profession ?? '',
  //       "employer":                   saved.employer ?? '',
  //       "employee_type":              saved.employeeType ?? '',
  //       "job_title":                  saved.jobTitle ?? '',
  //       "income":                     saved.income ?? '',
  //       "business":                   saved.business ?? '',
  //       "business_text":              saved.businessText ?? '',
  //       "lift_style_and_interest":    saved.lifeStyleAndInterest ?? [],
  //       "future_plan":                saved.futurePlan ?? '',
  //       "family_involvement":         saved.familyInvolvement ?? '',
  //       "marriage_period":            saved.marriagePeriod ?? '',
  //       "smoke":                      saved.smoke ?? '',
  //       "halal_food":                 saved.halalFood ?? '',
  //       "for_girl":                   saved.forGirl ?? '',
  //       "for_boy":                    saved.forBoy ?? '',
  //       "life_partner":               saved.lifePartner ?? '',
  //
  //       "attach_1":   saved.attach1Base64 ?? '',
  //       "attached_2": saved.attach2Base64 ?? '',   // ⚠️ API typo as-is
  //       "attach_3":   saved.attach3Base64 ?? '',
  //       "attach_4":   saved.attach4Base64 ?? '',
  //       // "attach_1":                   saved.attach1 ?? '',
  //       // "attached_2":                 saved.attach2 ?? '',   // ⚠️ API typo as-is
  //       // "attach_3":                   saved.attach3 ?? '',
  //       // "attach_4":                   saved.attach4 ?? '',
  //       "bio":                        saved.bio ?? '',
  //       "marriage_intension":         saved.marriageIntension ?? '',
  //       "creater_profile":            saved.createrProfile ?? '',
  //       "enable_notification":        saved.enableNotification ?? '',
  //     }
  //   };
  // }

  // ── Next button ──────────────────────────────────────────────────────────
  // void _nextStep() {
  //   _saveCurrentStep();
  //
  //   if (_currentStep < 6) {
  //     _pageController.nextPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   } else {
  //     // ✅ Last step — build payload and submit
  //     final payload = _buildSubmitPayload();
  //     newDocVM.submitSetUpProfileData(payload, this);
  //   }
  // }
  // ✅ Async banao — base64 conversion ke liye
  Future<Map<String, dynamic>> _buildSubmitPayload() async {
    final pref  = context.read<IPrefHelper>();
    final saved = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();
    final userId = pref.loginModel?.data?.user?.email ?? '';

    // ✅ Local paths se base64 on-the-fly banao
    final List<String> base64List = [];
    final paths = [
      saved.attach1 ?? '',
      saved.attach2 ?? '',
      saved.attach3 ?? '',
      saved.attach4 ?? '',
    ].where((p) => p.isNotEmpty).toList();

    for (final path in paths) {
      final file = File(path);
      if (file.existsSync()) {
        final b64 = await _fileToBase64(file);
        base64List.add(b64);
        print("✅ base64 generated, length: ${b64.length}");
      }
    }

    print("📦 Total base64 images for payload: ${base64List.length}");

    return {
      "data": {
        "user_id":          userId,
        "profile_name":     saved.profileName ?? '',
        "last_name":        saved.lastName ?? '',
        "gender":           saved.gender ?? '',
        "date_of_birth":    saved.dateOfBirth ?? '',
        "mother_tongue":    saved.motherTongue ?? '',
        "caste":            saved.caste ?? '',
        "hight":            saved.height ?? '',
        "weight":           saved.weight ?? '',
        "material_status":  saved.materialStatus ?? '',
        "country":          saved.country ?? '',
        "ethnicity":        saved.ethnicity ?? '',
        "nationality":      saved.nationality ?? '',
        "religion":         saved.religion ?? '',
        "belongs_to":       saved.belongsTo ?? '',
        "religious_practice": saved.religiousPractice ?? '',
        "zodiac_sign":      saved.zodiacSign ?? '',
        "father_name":      saved.fatherName ?? '',
        "father_occupation": saved.fatherOccupation ?? '',
        "family_values":    saved.familyValues ?? '',
        "living_arrangement": saved.livingArrangement ?? '',
        "married":          saved.married ?? '',
        "unmarried":        saved.unmarried ?? '',
        "house_size":       saved.houseSize ?? '',
        "area_society":     saved.areaSociety ?? '',
        "can_move_abroad_for_marriage": saved.canMoveAbroadForMarriage ?? '',
        "have_childern":    saved.haveChildren ?? '',
        "other_family_details": saved.otherFamilyDetails ?? '',
        "qualification":    saved.qualification ?? '',
        "name_institution": saved.nameInstitution ?? '',
        "profession":       saved.profession ?? '',
        "employer":         saved.employer ?? '',
        "employee_type":    saved.employeeType ?? '',
        "job_title":        saved.jobTitle ?? '',
        "income":           saved.income ?? '',
        "business":         saved.business ?? '',
        "business_text":    saved.businessText ?? '',
        "life_style_and_interest": saved.lifeStyleAndInterest ?? [],
        "future_plan":      saved.futurePlan ?? '',
        "family_involvement": saved.familyInvolvement ?? '',
        "marriage_period":  saved.marriagePeriod ?? '',
        "smoke":            saved.smoke ?? '',
        "halal_food":       saved.halalFood ?? '',
        "for_girl":         saved.forGirl ?? '',
        "for_boy":          saved.forBoy ?? '',
        "life_partner":     saved.lifePartner ?? '',
        // ✅ On-the-fly base64
        "attach_1":   base64List.isNotEmpty ? base64List[0] : '',
        "attached_2": base64List.length > 1 ? base64List[1] : '',
        "attach_3":   base64List.length > 2 ? base64List[2] : '',
        "attach_4":   base64List.length > 3 ? base64List[3] : '',
        "bio":               saved.bio ?? '',
        "marriage_intension": saved.marriageIntension ?? '',
        "creater_profile":   saved.createrProfile ?? '',
        "enable_notification": saved.enableNotification ?? '',
      }
    };
  }
  Future<void> _nextStep() async {
    await _saveCurrentStep();

    if (_currentStep < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // ✅ await karo — async ban gaya
      final payload = await _buildSubmitPayload();
      newDocVM.submitSetUpProfileData(payload, this);
    }
  }
  // ── Previous button ──────────────────────────────────────────────────────
  // void _previousStep() {
  //   _saveCurrentStep();
  //   if (_currentStep > 0) {
  //     _pageController.previousPage(
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }
  Future<void> _previousStep() async {
    await _saveCurrentStep();
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
  Future<bool> _onWillPop() async {
    _showBackDialog();
    return false;
  }
  void _showBackDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Progress Save Karein?",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          "Are you sure you want to save Data?",
        ),
        actions: [
          // ── Clear ──────────────────────────────────────────────────
          TextButton(
            onPressed: () {
              context.read<IPrefHelper>().clearSetupProfile();
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: Text("Clear",
                style: TextStyle(color: Colors.red.shade400)),
          ),
          // ── Save ───────────────────────────────────────────────────
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              _saveCurrentStep();
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text("Save",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
  void _showVerificationDialog() {
    if (!mounted) return; // ✅ guard

    print("🟢 Showing verification dialog"); // ✅ debug

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => VerificationDialog(), // make sure this widget exists & builds
    );
  }
  // void _showVerificationDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) => VerificationDialog(),
  //   );
  // }
  final List<String> _stepTitles = [
    "Tell us about yourself",
    "Tell us about Family",
    "Education and Profession",
    "Life Style and Interest",
    "Partner Preferences / Requirements",
    "Add your Pictures",
    "Bio and Other Details",
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: ColorManager.white,
        resizeToAvoidBottomInset: true,
        body: Consumer2<SignUpViewModel, AuthViewModel>(
          builder: (context, signUpProvider, authProvider, child) {
            signUpVM = signUpProvider;
            authVM   = authProvider;
            return Consumer<SetUpProfileViewModel>(
              builder: (context, setupProvider, _) {
                newDocVM = setupProvider;
                return _buildBody(context);
              },
            );
          },
        ),
      ),
    );
  }
  Widget _buildBody(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          width: size.width,
          height: size.height * 0.75,
          child: Image.asset(Assets.signup_back, fit: BoxFit.fill),
        ),

        Positioned(
          top: size.height * 0.080,
          left: widget.dimens.k20,
          right: widget.dimens.k20,
          child: Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: ColorManager.white.withOpacity(.5),
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: size.height * 0.91,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft:  Radius.circular(widget.dimens.k25),
                topRight: Radius.circular(widget.dimens.k25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Title + step counter ───────────────────────────────
                  SizedBox(
                    height: widget.dimens.k70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.dimens.k13.verticalBoxPadding,
                        Text(
                          _stepTitles[_currentStep],
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: widget.dimens.k17,
                          ),
                        ),
                        Text(
                          "Step ${_currentStep + 1} of 7",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: ColorManager.fieldTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.dimens.k18),
                    child: Row(
                      children: List.generate(7, (index) {
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
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) =>
                          setState(() => _currentStep = index),
                      children: [
                        TellAboutYourSelfView(key: _page1Key),
                        TellAboutYourFamilyView(key: _page2Key),
                        EducationProfessionView(key: _page3Key),
                        LifStyleInterestView(key: _page4Key),
                        PartnerPreferencesView(key: _page5Key),
                        AddYourPictures(key: _page6Key),
                        BioAndOtherDetailsView(key: _page7Key),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      widget.dimens.k18, 0,
                      widget.dimens.k18, widget.dimens.k25,
                    ),
                    child: _currentStep == 0

                    // Step 1 — only Next
                        ? PrimaryButton(
                      width: double.infinity,
                      onPressed: _nextStep,
                      childText: "Next",
                      issquare: false,
                      color: ColorManager.primary,
                    )

                    // Step 2-7 — Previous + Next/Submit
                        : Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        PrimaryButton(
                          width: size.width / 2.3,
                          onPressed: _previousStep,
                          childText: "Previous",
                          textStyle: TextStyle(
                              color: ColorManager.primary),
                          issquare: false,
                          color: ColorManager.previous,
                        ),

                        // ✅ Submit button loading state
                        newDocVM.apiResponse is Loading
                            ? SizedBox(
                          width: size.width / 2.3,
                          height: 50,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : PrimaryButton(
                          width: size.width / 2.3,
                          onPressed: _nextStep,
                          childText: _currentStep == 6
                              ? "Submit"
                              : "Next",
                          issquare: false,
                          color: ColorManager.primary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  @override
  onSuccess(result) {
    try {
      print("FULL RESULT: $result");

      // ✅ result is already a String — no .data needed
      String message = "";

      if (result is Map) {
        message = result['message']?.toString() ?? "";
      } else if (result is String) {
        message = result;
      }

      if (message.isEmpty) {
        message = "Profile created successfully";
      }

      context.read<IPrefHelper>().clearSetupProfile();

      MyToast.showToast(
        message: message,
        typeToast: TypeToast.success,
      );
      widget.navigator.pushNamedAndRemoveUntil(RouteManager.rBottomBarView);

      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   if (mounted) {
      //     _showVerificationDialog();
      //   } else {
      //     print("❌ Context not mounted, dialog skipped");
      //   }
      // });

    } catch (e, stack) {
      print("❌ onSuccess ERROR: $e");
      print(stack);
    }
  }
  @override
  onError(String error) {
    MyToast.showToast(message: error, typeToast: TypeToast.error);
  }
}