import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_field.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';

class PartnerPreferencesView extends BaseStateFullWidget {
  PartnerPreferencesView({super.key});

  @override
  State<PartnerPreferencesView> createState() => PartnerPreferencesViewState();
}

class PartnerPreferencesViewState extends State<PartnerPreferencesView> {
  final TextEditingController lifePartnerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFromPrefs());
  }

  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      lifePartnerController.text = saved.lifePartner ?? '';
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
      // ── Page 3 — keep previous ────────────────────────────────────────
      qualification:   current.qualification,
      nameInstitution: current.nameInstitution,
      profession:      current.profession,
      employer:        current.employer,
      employeeType:    current.employeeType,
      jobTitle:        current.jobTitle,
      income:          current.income,
      business:        current.business,
      businessText:    current.businessText,
      // ── Page 4 — keep previous ────────────────────────────────────────
      lifeStyleAndInterest: current.lifeStyleAndInterest,
      futurePlan:           current.futurePlan,
      familyInvolvement:    current.familyInvolvement,
      marriagePeriod:       current.marriagePeriod,
      smoke:                current.smoke,
      halalFood:            current.halalFood,
      forGirl:              current.forGirl,
      forBoy:               current.forBoy,
      // ── Page 5 (partner) — this screen ───────────────────────────────
      lifePartner:          lifePartnerController.text.trim(),

      images: current.images,
      attach1: current.attach1,
      attach2:current.attach2,
      attach3:current.attach3,
      attach4: current.attach4,
      // ── Page 6 — keep previous ────────────────────────────────────────
      bio:                current.bio,
      marriageIntension:  current.marriageIntension,
      createrProfile:     current.createrProfile,
      enableNotification: current.enableNotification,
    );

    context.read<IPrefHelper>().saveSetupProfile(updated);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringManager.lifePartner,
              style: context.textTheme.bodySmall?.copyWith(
                  color: ColorManager.fieldHintColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0)),
          widget.dimens.k3.verticalBoxPadding,
          CustomField(
            hintText: "Enter here",
            keyboardType: TextInputType.text,
            controller: lifePartnerController,
            maxLines: 3,
            validator: (input) => AppValidators.fieldValidator(input),
          ),
        ],
      ),
    );
  }
}