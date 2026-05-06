import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_field.dart';
import '../../../application/core/result.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../../widgets/toast.dart';

class BioAndOtherDetailsView extends BaseStateFullWidget {
  BioAndOtherDetailsView({super.key});

  @override
  State<BioAndOtherDetailsView> createState() => BioAndOtherDetailsViewState();
}

class BioAndOtherDetailsViewState extends State<BioAndOtherDetailsView>
    implements Result<String>, ErrorResult {
  final TextEditingController bioController       = TextEditingController();
  final TextEditingController intentionController = TextEditingController();
  String? creating;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SetUpProfileViewModel>().getAllProfileCreatorsData(this);
      _loadFromPrefs();
    });
  }

  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      bioController.text       = saved.bio ?? '';
      intentionController.text = saved.marriageIntension ?? '';
      creating                 = saved.createrProfile;
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
      lifePartner:          current.lifePartner,

      images: current.images,
      attach1: current.attach1,
      attach2:current.attach2,
      attach3:current.attach3,
      attach4: current.attach4,
      // ── Page 7 (bio) — this screen ────────────────────────────────────
      bio:                bioController.text.trim(),
      marriageIntension:  intentionController.text.trim(),
      createrProfile:     creating,
      enableNotification: current.enableNotification,
    );

    context.read<IPrefHelper>().saveSetupProfile(updated);
  }

  // ── Called from SignUpCreationView on Submit ─────────────────────────────
  SetupProfilePrefModel? getFinalData() {
    saveSetupProfileStep();
    return context.read<IPrefHelper>().retrieveSetupProfile();
  }

  @override
  Widget build(BuildContext context) {
    final newDocVM = context.watch<SetUpProfileViewModel>();
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(context, "Bio"),
          widget.dimens.k3.verticalBoxPadding,
          CustomField(
            hintText: "Enter here",
            keyboardType: TextInputType.text,
            controller: bioController,
            maxLines: 3,
            validator: (i) => AppValidators.fieldValidator(i),
          ),
          widget.dimens.k10.verticalBoxPadding,
          _label(context, "Marriage Intention"),
          widget.dimens.k3.verticalBoxPadding,
          CustomField(
            hintText: "Enter here",
            keyboardType: TextInputType.text,
            controller: intentionController,
            maxLines: 3,
            validator: (i) => AppValidators.fieldValidator(i),
          ),
          widget.dimens.k10.verticalBoxPadding,
          _label(context, "Who is Creating this Profile?"),
          widget.dimens.k3.verticalBoxPadding,
          CustomDropDown<String>(
            list: newDocVM.profileCreatorsModel.data?.profileCreators
                ?.map((e) => e.name ?? '')
                .toList() ??
                [],
            selectedItem: creating,
            hintText: "Select who is creating",
            onChanged: (val) => setState(() => creating = val),
          ),
        ],
      ),
    );
  }

  Widget _label(BuildContext context, String text) => Text(text,
      style: context.textTheme.bodySmall?.copyWith(
          color: ColorManager.fieldHintColor,
          fontWeight: FontWeight.w500,
          fontSize: 13.0));

  @override
  void onSuccess(String result) => MyToast.showToast(message: result);

  @override
  onError(String error) => MyToast.showToast(message: error);
}