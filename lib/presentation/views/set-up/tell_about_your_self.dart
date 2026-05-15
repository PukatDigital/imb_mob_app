import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/calendar_view.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_field.dart';
import '../../../application/network/result.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/toast.dart';

enum Gender { male, female }

class TellAboutYourSelfView extends BaseStateFullWidget {
  TellAboutYourSelfView({super.key});

  @override
  State<TellAboutYourSelfView> createState() => TellAboutYourSelfViewState();
}

class TellAboutYourSelfViewState extends State<TellAboutYourSelfView>
    implements ErrorResult {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ethnicityController = TextEditingController();
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();
  String? motherTongue;
  String? caste;
  String? manHeight;
  String? manWeight;
  String? maritalStatus;
  String? country;
  String? ethnicity;
  String? nationality;
  String? religion;
  String? belong;
  String? religious;
  String? zodiac;
  Gender? selectedGender;
  late SetUpProfileViewModel newDocVM;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SetUpProfileViewModel>().getMotherTonguesData(this);
      context.read<SetUpProfileViewModel>().getAllCasteData(this);
      context.read<SetUpProfileViewModel>().getAllHeightsData(this);
      context.read<SetUpProfileViewModel>().getAllWeightsData(this);
      context.read<SetUpProfileViewModel>().getAllMartialStatusData(this);
      context.read<SetUpProfileViewModel>().getAllCountryData(this);
      context.read<SetUpProfileViewModel>().getAllNationalitiesData(this);
      context.read<SetUpProfileViewModel>().getAllReligionsData(this);
      context.read<SetUpProfileViewModel>().getAllBelongsToData(this);
      context.read<SetUpProfileViewModel>().getAllReligiousPracticesData(this);
      context.read<SetUpProfileViewModel>().getAllZodiacSignsData(this);
      context.read<SetUpProfileViewModel>().getAllEthnicitiesData(this);
      _loadFromPrefs();
    });
  }
  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      firstNameController.text  = saved.profileName ?? '';
      lastNameController.text   = saved.lastName ?? '';
      ethnicity  = saved.ethnicity;
      _dateController.text      = saved.dateOfBirth ?? '';
      motherTongue              = saved.motherTongue;
      caste                     = saved.caste;
      manHeight                 = saved.height;
      manWeight                 = saved.weight;
      maritalStatus             = saved.materialStatus;
      country                   = saved.country;
      nationality               = saved.nationality;
      religion                  = saved.religion;
      belong                    = saved.belongsTo;
      religious                 = saved.religiousPractice;
      zodiac                    = saved.zodiacSign;
      if (saved.gender == 'Male') selectedGender = Gender.male;
      if (saved.gender == 'Female') selectedGender = Gender.female;
    });
  }
  void saveSetupProfileStep() {
    final current = context.read<IPrefHelper>().retrieveSetupProfile()
        ?? SetupProfilePrefModel();

    final updated = SetupProfilePrefModel(
      // ── Page 1 — this screen ──────────────────────────────────────────
      profileName:       firstNameController.text.trim(),
      lastName:          lastNameController.text.trim(),
      gender:            selectedGender == Gender.male ? 'Male' : 'Female',
      dateOfBirth:       _dateController.text.trim(),
      motherTongue:      motherTongue,
      caste:             caste,
      height:            manHeight,
      weight:            manWeight,
      materialStatus:    maritalStatus,
      country:           country,
      ethnicity:         ethnicity,
      nationality:       nationality,
      religion:          religion,
      belongsTo:         belong,
      religiousPractice: religious,
      zodiacSign:        zodiac,
      profileCompleted: current.profileCompleted,
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
      images: current.images,
      attach1: current.attach1,
      attach2:current.attach2,
      attach3:current.attach3,
      attach4: current.attach4,
      // ── Page 5 — keep previous ────────────────────────────────────────
      bio:                current.bio,
      marriageIntension:  current.marriageIntension,
      createrProfile:     current.createrProfile,
      enableNotification: current.enableNotification,
    );

    context.read<IPrefHelper>().saveSetupProfile(updated);
  }
  void _openCalendarDialog(TextEditingController controller) {
    DateTime tempSelected = _selectedDate ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(        // ✅ manages state inside dialog
        builder: (context, setDialogState) {
          return AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: Text("Select Date",
                style: context.textTheme.titleMedium!
                    .copyWith(color: ColorManager.primary)),
            content: SizedBox(
              width: double.maxFinite,
              height: 350,
              child: CalendarView(
                selectedDate: tempSelected,
                isPrevious: true,
                onDaySelected: (selectedDay, focusedDay) {
                  setDialogState(() {               // ✅ only updates inside dialog
                    tempSelected = selectedDay;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),  // ✅ cancel
                child: Text("Cancel",
                    style: TextStyle(color: ColorManager.fieldTextColor)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);                 // ✅ confirm then update
                  if (mounted) {
                    setState(() {
                      _selectedDate = tempSelected;
                      controller.text =
                      "${tempSelected.year}-${tempSelected.month.toString().padLeft(2, '0')}-${tempSelected.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                child: Text("Confirm",
                    style: TextStyle(color: ColorManager.primary)),
              ),
            ],
          );
        },
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<SetUpProfileViewModel>(
        builder: (context, provider, child) {
          newDocVM = provider;
          return newDocVM.apiResponse is Loading
              ? Center(child: Loader())
              : SingleChildScrollView(
            padding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(context, StringManager.firstName, required: true),
                CustomField(
                  hintText: StringManager.enterFirstName,
                  keyboardType: TextInputType.text,
                  controller: firstNameController,
                  validator: (input) =>
                      AppValidators.fieldValidator(input),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.lastNameText, required: true),
                CustomField(
                  hintText: StringManager.enterLastName,
                  keyboardType: TextInputType.text,
                  controller: lastNameController,
                  validator: (input) =>
                      AppValidators.fieldValidator(input),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.genderName, required: true),
                widget.dimens.k10.verticalBoxPadding,
                Row(
                  children: [
                    _genderItem(
                        context: context,
                        gender: Gender.male,
                        title: 'Male',
                        icon: Assets.male),
                    const SizedBox(width: 15),
                    _genderItem(
                        context: context,
                        gender: Gender.female,
                        title: 'Female',
                        icon: Assets.feMale),
                  ],
                ),
                widget.dimens.k13.verticalBoxPadding,
                _label(context, StringManager.bornWhen, required: true),
                CustomField(
                  controller: _dateController,
                  hintText: "dd/mm/yyyy",
                  readonly: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today_outlined,
                        color: ColorManager.textColorSubTitle),
                    onPressed: () =>
                        _openCalendarDialog(_dateController),
                  ),
                  onTap: () => _openCalendarDialog(_dateController),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.motherTongue),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.motherTonguesModel.data?.motherTongues
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: motherTongue,
                  hintText: "Select your mother tongue",
                  onChanged: (val) =>
                      setState(() => motherTongue = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.caste),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.castesModel.data?.castes
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: caste,
                  hintText: "Select your caste",
                  onChanged: (val) => setState(() => caste = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.manHeight),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.heightsModel.data?.heights
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: manHeight,
                  hintText: "Select your height",
                  onChanged: (val) => setState(() => manHeight = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.manWeight),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.weightsModel.data?.weights
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: manWeight,
                  hintText: "Select your weight",
                  onChanged: (val) => setState(() => manWeight = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.maritalStatus,
                    required: true),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.martialStatuses.data?.martialStatuses
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: maritalStatus,
                  hintText: "Select your marital status",
                  onChanged: (val) =>
                      setState(() => maritalStatus = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.liveCountry, required: true),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.countriesModel.data?.countries
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: country,
                  hintText: "Select your country",
                  onChanged: (val) => setState(() => country = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, "Which city do you live in?"),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.ethnicitiesModel.data?.ethnicities
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: ethnicity,
                  hintText: "Select your city",
                  onChanged: (val) => setState(() => ethnicity = val),
                ),
                // CustomField(
                //   hintText: "Enter your ethnicity or city",
                //   keyboardType: TextInputType.text,
                //   controller: ethnicityController,
                //   validator: (input) =>
                //       AppValidators.fieldValidator(input),
                // ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.liveNationality,
                    required: true),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.nationalitiesModel.data?.nationalities
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: nationality,
                  hintText: "Select your nationality",
                  onChanged: (val) =>
                      setState(() => nationality = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.religion, required: true),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.religionsModel.data?.religions
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: religion,
                  hintText: "Select your religion",
                  onChanged: (val) => setState(() => religion = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.belong),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.belongsToModel.data?.belongsTo
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: belong,
                  hintText: "Select your sect",
                  onChanged: (val) => setState(() => belong = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.religious),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.religiousPracticesModel.data
                      ?.religiousPractices
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: religious,
                  hintText: "Select how religious you are",
                  onChanged: (val) => setState(() => religious = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
                _label(context, StringManager.zodiac),
                widget.dimens.k3.verticalBoxPadding,
                CustomDropDown<String>(
                  list: newDocVM.zodiacSignsModel.data?.zodiacSigns
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem: zodiac,
                  hintText: "Select your zodiac sign",
                  onChanged: (val) => setState(() => zodiac = val),
                ),
                widget.dimens.k10.verticalBoxPadding,
              ],
            ),
          );
        });
  }
  Widget _label(BuildContext context, String text,
      {bool required = false}) {
    return Text.rich(TextSpan(
      text: text,
      style: context.textTheme.bodySmall?.copyWith(
        color: ColorManager.fieldHintColor,
        fontWeight: FontWeight.w500,
        fontSize: 13.0,
      ),
      children: required
          ? [
        TextSpan(
            text: " *",
            style: context.textTheme.bodySmall
                ?.copyWith(color: ColorManager.primary))
      ]
          : [],
    ));
  }
  Widget _genderItem({
    required BuildContext context,
    required Gender gender,
    required String title,
    required String icon,
  }) {
    final bool isSelected = selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => selectedGender = gender),
      child: Container(
        height: 44,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected
              ? ColorManager.genderContainer
              : ColorManager.loginContainer,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon,
                height: 17,
                width: 17,
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.fieldTextColor),
            const SizedBox(width: 5),
            Text(title,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? ColorManager.primary
                      : ColorManager.fieldTextColor,
                )),
          ],
        ),
      ),
    );
  }
  @override
  onError(String error) => MyToast.showToast(message: error);
}