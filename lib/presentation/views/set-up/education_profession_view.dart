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

class EducationProfessionView extends BaseStateFullWidget {
  EducationProfessionView({super.key});

  @override
  State<EducationProfessionView> createState() =>
      EducationProfessionViewState();
}

class EducationProfessionViewState extends State<EducationProfessionView>
    implements ErrorResult {
  final TextEditingController educationalController  = TextEditingController();
  final TextEditingController employerController     = TextEditingController();
  final TextEditingController jobTitleController     = TextEditingController();
  final TextEditingController businessOwnController  = TextEditingController();

  String? qualification;
  String? profession;
  String? employeeType;
  String? monthlyRange;

  late SetUpProfileViewModel newDocVM;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SetUpProfileViewModel>().getAllEducationData(this);
      context.read<SetUpProfileViewModel>().getAllProfessionsData(this);
      context.read<SetUpProfileViewModel>().getAllEmployeeTypesData(this);
      context.read<SetUpProfileViewModel>().getAllIncomeRangesData(this);
      _loadFromPrefs();
    });
  }

  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      qualification             = saved.qualification;
      educationalController.text = saved.nameInstitution ?? '';
      profession                = saved.profession;
      employerController.text   = saved.employer ?? '';
      employeeType              = saved.employeeType;
      jobTitleController.text   = saved.jobTitle ?? '';
      monthlyRange              = saved.income;
      businessOwnController.text = saved.businessText ?? '';
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
      // ── Page 2 — keep previous ────────────────────────────────────────
      fatherName:               current.fatherName,
      fatherOccupation:         current.fatherOccupation,
      familyValues:             current.familyValues,
      livingArrangement:        current.livingArrangement,
      married:                  current.married,
      unmarried:                current.unmarried,
      houseSize:                current.houseSize,
      areaSociety:              current.areaSociety,
      canMoveAbroadForMarriage: current.canMoveAbroadForMarriage,
      haveChildren:             current.haveChildren,
      otherFamilyDetails:       current.otherFamilyDetails,
      // ── Page 3 — this screen ─────────────────────────────────────────
      qualification:   qualification,
      nameInstitution: educationalController.text.trim(),
      profession:      profession,
      employer:        employerController.text.trim(),
      employeeType:    employeeType,
      jobTitle:        jobTitleController.text.trim(),
      income:          monthlyRange,
      business:        current.business,
      businessText:    businessOwnController.text.trim(),
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
          final employeeTypeList = newDocVM
              .employeeTypesModel
              .data
              ?.employeeTypes
              ?.map((e) => e.name)
              .where((e) => e != null && e.isNotEmpty)
              .cast<String>()
              .toSet()
              .toList() ??
              [];
          return newDocVM.apiResponse is Loading
              ?  Center(child: Loader())
              : SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(context, StringManager.qualification),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.educationModel.data?.education
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: qualification,
                  hintText: "Select qualification",
                  onChanged: (val) =>
                      setState(() => qualification = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.educational),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your educational institute",
                    keyboardType: TextInputType.text,
                    controller: educationalController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.profession),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.professionsModel.data?.professions
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: profession,
                  hintText: "Select profession",
                  onChanged: (val) => setState(() => profession = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.employer),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your employer",
                    keyboardType: TextInputType.text,
                    controller: employerController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.employeeType),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: employeeTypeList,
                  selectedItem: employeeTypeList.contains(employeeType)
                      ? employeeType
                      : null,
                  hintText: "Select employee type",
                  onChanged: (val) {
                    setState(() {
                      employeeType = val;
                    });
                  },
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.jobTitle),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your job title",
                    keyboardType: TextInputType.text,
                    controller: jobTitleController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.monthlyRange),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.incomeRangesModel.data?.incomeRanges
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: monthlyRange,
                  hintText: "Select income range",
                  onChanged: (val) =>
                      setState(() => monthlyRange = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.businessOwn),
                widget.dimens.k3.verticalBoxPadding,
                CustomField(
                    hintText: "Enter your business type",
                    keyboardType: TextInputType.text,
                    controller: businessOwnController,
                    validator: (i) => AppValidators.fieldValidator(i)),
                widget.dimens.k10.verticalBoxPadding,
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