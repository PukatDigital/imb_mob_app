import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_field.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/toast.dart';

class TellAboutYourFamilyView extends BaseStateFullWidget {
  TellAboutYourFamilyView({super.key});

  @override
  State<TellAboutYourFamilyView> createState() =>
      TellAboutYourFamilyViewState();
}

class TellAboutYourFamilyViewState extends State<TellAboutYourFamilyView>
    implements ErrorResult {
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController marriedController    = TextEditingController();
  final TextEditingController unmarriedController  = TextEditingController();
  final TextEditingController houseController      = TextEditingController();
  final TextEditingController societyController    = TextEditingController();
  final TextEditingController additionalController = TextEditingController();

  String? occupation;
  String? familyValue;
  String? currentlyLive;
  String? abroad;
  String? children;

  final List<String> abroadS   = ["Yes", "No"];
  final List<String> childrenS = ["Yes", "No"];

  late SetUpProfileViewModel newDocVM;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SetUpProfileViewModel>().getAllOccupationsData(this);
      context.read<SetUpProfileViewModel>().getAllFamilyValuesData(this);
      context.read<SetUpProfileViewModel>().getAllLivingArrangementsData(this);
      _loadFromPrefs();
    });
  }

  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      fatherNameController.text  = saved.fatherName ?? '';
      marriedController.text     = saved.married ?? '';
      unmarriedController.text   = saved.unmarried ?? '';
      houseController.text       = saved.houseSize ?? '';
      societyController.text     = saved.areaSociety ?? '';
      additionalController.text  = saved.otherFamilyDetails ?? '';
      occupation    = saved.fatherOccupation;
      familyValue   = saved.familyValues;
      currentlyLive = saved.livingArrangement;
      abroad        = saved.canMoveAbroadForMarriage;
      children      = saved.haveChildren;
    });
  }

  void saveSetupProfileStep() {
    final current = context.read<IPrefHelper>().retrieveSetupProfile()
        ?? SetupProfilePrefModel();

    final updated = SetupProfilePrefModel(
      // ── Page 1 — keep previous ────────────────────────────────────────
      profileName:       current.profileName,
      lastName:          current.lastName,
      gender:            current.gender,
      dateOfBirth:       current.dateOfBirth,
      profileCompleted: current.profileCompleted,
      motherTongue:      current.motherTongue,
      caste:             current.caste,
      height:            current.height,
      weight:            current.weight,
      materialStatus:    current.materialStatus,
      country:           current.country,
      ethnicity:         current.ethnicity,
      nationality:       current.nationality,
      religion:          current.religion,
      belongsTo:         current.belongsTo,
      religiousPractice: current.religiousPractice,
      zodiacSign:        current.zodiacSign,
      // ── Page 2 — this screen ─────────────────────────────────────────
      fatherName:               fatherNameController.text.trim(),
      fatherOccupation:         occupation,
      familyValues:             familyValue,
      livingArrangement:        currentlyLive,
      married:                  marriedController.text.trim(),
      unmarried:                unmarriedController.text.trim(),
      houseSize:                houseController.text.trim(),
      areaSociety:              societyController.text.trim(),
      canMoveAbroadForMarriage: abroad,
      haveChildren:             children,
      otherFamilyDetails:       additionalController.text.trim(),
      // ── Page 3 — keep previous ────────────────────────────────────────
      qualification:    current.qualification,
      nameInstitution:  current.nameInstitution,
      profession:       current.profession,
      employer:         current.employer,
      employeeType:     current.employeeType,
      jobTitle:         current.jobTitle,
      income:           current.income,
      business:         current.business,
      businessText:     current.businessText,
      // ── Page 4 — keep previous ────────────────────────────────────────
      lifeStyleAndInterest: current.lifeStyleAndInterest,
      futurePlan:           current.futurePlan,
      familyInvolvement:    current.familyInvolvement,
      marriagePeriod:       current.marriagePeriod,
      smoke:                current.smoke,
      halalFood:            current.halalFood,
      forGirl:              current.forGirl,
      forBoy:               current.forBoy,
      lifePartner:          current.lifePartner,
      // ── Page 5 — keep previous ────────────────────────────────────────
      images: current.images,
      attach1: current.attach1,
      attach2:current.attach2,
      attach3:current.attach3,
      attach4: current.attach4,

      bio:                current.bio,
      marriageIntension:  current.marriageIntension,
      createrProfile:     current.createrProfile,
      enableNotification: current.enableNotification,
    );

    context.read<IPrefHelper>().saveSetupProfile(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileViewModel>(
        builder: (context, provider, child) {
          newDocVM = provider;
          return newDocVM.apiResponse is Loading
              ?  Center(child: Loader())
              : SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(context, StringManager.fatherName),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your father's name",
                    keyboardType: TextInputType.text,
                    controller: fatherNameController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.fatherOccupation),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.occupationsModel.data?.occupations
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: occupation,
                  hintText: "Select your father's occupation",
                  onChanged: (val) => setState(() => occupation = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.fatherValue),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.familyValuesModel.data?.familyValues
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: familyValue,
                  hintText: "Select your family values",
                  onChanged: (val) => setState(() => familyValue = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, "How do you currently live with?"),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.livingArrangementsModel.data?.livingArrangements
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: currentlyLive,
                  hintText: "Select who you live with ",
                  onChanged: (val) =>
                      setState(() => currentlyLive = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.married),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter married siblings",
                    keyboardType: TextInputType.number,
                    controller: marriedController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.unmarried),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter unmarried siblings",
                    keyboardType: TextInputType.number,
                    controller: unmarriedController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.house),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your house size",
                    keyboardType: TextInputType.text,
                    controller: houseController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.society),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter society or area name",
                    keyboardType: TextInputType.text,
                    controller: societyController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.abroad),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: abroadS,
                  selectedItem: abroad,
                  hintText: "Select if you can move abroad",
                  onChanged: (val) => setState(() => abroad = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.children),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: childrenS,
                  selectedItem: children,
                  hintText: "Select if you have children",
                  onChanged: (val) => setState(() => children = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.additionalDetails),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter here",
                    keyboardType: TextInputType.text,
                    controller: additionalController,
                    maxLines: 3,
                    validator: (i) => AppValidators.fieldValidator(i)),
              ],
            ),
          );
        });
  }

  Widget _label(BuildContext context, String text) => Text(text,
      style: context.textTheme.bodySmall?.copyWith(
          color: ColorManager.fieldHintColor,
          fontWeight: FontWeight.w500,
          fontSize: 13.0));

  @override
  onError(String error) => MyToast.showToast(message: error);
}