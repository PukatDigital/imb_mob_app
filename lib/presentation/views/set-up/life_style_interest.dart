import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/set-up/set_up_profile_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/custom_field.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/toast.dart';

class LifStyleInterestView extends BaseStateFullWidget {
  LifStyleInterestView({super.key});

  @override
  State<LifStyleInterestView> createState() => LifStyleInterestViewState();
}
class LifStyleInterestViewState extends State<LifStyleInterestView>
    implements ErrorResult {
  final TextEditingController interestController = TextEditingController();

  List<String> filteredInterests = [];
  List<String> selectedInterests = [];

  String? futurePlan;
  String? marriageDecision;
  String? marriagePlain;
  String? smoke;
  String? halalFood;
  String? hijab;
  String? beardMan;

  final List<String> yesNo = ["Yes", "No"];

  late SetUpProfileViewModel newDocVM;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newDocVM = context.read<SetUpProfileViewModel>();
      newDocVM.getAllFuturePlansData(this);
      newDocVM.getAllMarriagePeriodsData(this);
      newDocVM.getAllLifeStyleAndInterestData(this);
      _loadFromPrefs();
    });
  }

  void _loadFromPrefs() {
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    setState(() {
      selectedInterests = List<String>.from(saved.lifeStyleAndInterest ?? []);
      futurePlan = saved.futurePlan;
      marriagePlain = saved.marriagePeriod;
      smoke = saved.smoke;
      halalFood = saved.halalFood;
      hijab = saved.forGirl;
      beardMan = saved.forBoy;
      marriageDecision = saved.familyInvolvement;
    });
  }

  void saveSetupProfileStep() {
    final current = context.read<IPrefHelper>().retrieveSetupProfile()
        ?? SetupProfilePrefModel();

    final updated = SetupProfilePrefModel(
      profileName: current.profileName,
      lastName: current.lastName,
      gender: current.gender,
      dateOfBirth: current.dateOfBirth,
      motherTongue: current.motherTongue,
      caste: current.caste,
      height: current.height,
      weight: current.weight,
      materialStatus: current.materialStatus,
      country: current.country,
      ethnicity: current.ethnicity,
      nationality: current.nationality,
      religion: current.religion,
      belongsTo: current.belongsTo,
      religiousPractice: current.religiousPractice,
      zodiacSign: current.zodiacSign,
      fatherName: current.fatherName,
      fatherOccupation: current.fatherOccupation,
      familyValues: current.familyValues,
      livingArrangement: current.livingArrangement,
      married: current.married,
      unmarried: current.unmarried,
      houseSize: current.houseSize,
      areaSociety: current.areaSociety,
      canMoveAbroadForMarriage: current.canMoveAbroadForMarriage,
      haveChildren: current.haveChildren,
      otherFamilyDetails: current.otherFamilyDetails,
      qualification: current.qualification,
      nameInstitution: current.nameInstitution,
      profession: current.profession,
      employer: current.employer,
      employeeType: current.employeeType,
      jobTitle: current.jobTitle,
      income: current.income,
      business: current.business,
      businessText: current.businessText,
      lifeStyleAndInterest: selectedInterests,
      futurePlan: futurePlan,
      familyInvolvement: marriageDecision,
      marriagePeriod: marriagePlain,
      smoke: smoke,
      halalFood: halalFood,
      forGirl: hijab,
      forBoy: beardMan,
      lifePartner: current.lifePartner,
      images: current.images,
      attach1: current.attach1,
      attach2: current.attach2,
      attach3: current.attach3,
      attach4: current.attach4,
      bio: current.bio,
      marriageIntension: current.marriageIntension,
      createrProfile: current.createrProfile,
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
            ? Center(child: Loader())
            : SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: widget.dimens.k15,
            vertical: widget.dimens.k30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(context, StringManager.interest),
              widget.dimens.k3.verticalBoxPadding,
              CustomField(
                hintText: "Enter your life style and interest",
                controller: interestController,
                keyboardType: TextInputType.text,
                onTap: () {
                  setState(() {
                    _updateFilteredInterests('');
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _updateFilteredInterests(value);
                  });
                },
              ),
            // inside build method
            if (filteredInterests.isNotEmpty)
        Container(
          margin: EdgeInsets.only(top: widget.dimens.k3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredInterests.length,
            itemBuilder: (ctx, i) {
              if (i >= filteredInterests.length) return const SizedBox(); // ✅ extra safety
              final item = filteredInterests[i];
              return InkWell(
                onTap: () {
                  setState(() {
                    if (!selectedInterests.contains(item)) {
                      selectedInterests.add(item);
                    }
                    interestController.clear();
                    filteredInterests.clear();
                  });
                  FocusScope.of(context).unfocus();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.dimens.k12,
                    vertical: widget.dimens.k5,
                  ),
                  child: Text(
                    item,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontSize: widget.dimens.k13,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
              widget.dimens.k10.verticalBoxPadding,
              if (selectedInterests.isNotEmpty)
                Wrap(
                  spacing: widget.dimens.k8,
                  runSpacing: 8,
                  children: selectedInterests.map((item) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(widget.dimens.k10),
                        color: ColorManager.loginContainer,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(item,
                              style: context.textTheme.bodyMedium?.copyWith(
                                  color: ColorManager.textColorSubTitle,
                                  fontSize: 12)),
                          widget.dimens.k6.horizontalBoxPadding,
                          GestureDetector(
                            onTap: () =>
                                setState(() => selectedInterests.remove(item)),
                            child: const Icon(Icons.close,
                                size: 14,
                                color: ColorManager.textColorSubTitle),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              widget.dimens.k10.verticalBoxPadding,
              _buildDropdown(
                context,
                label: StringManager.futurePlan,
                list: newDocVM.futurePlansModel.data?.futurePlans
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                    [],
                selectedItem: futurePlan,
                hint: "Select future plan",
                onChanged: (val) => setState(() => futurePlan = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.marriageDecision,
                list: yesNo,
                selectedItem: marriageDecision,
                hint: "Family involvement in marriage decision",
                onChanged: (val) => setState(() => marriageDecision = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.planning,
                list: newDocVM.marriagePeriodsModel.data?.marriagePeriods
                    ?.map((e) => e.name ?? '')
                    .toList() ??
                    [],
                selectedItem: marriagePlain,
                hint: "Select marriage period",
                onChanged: (val) => setState(() => marriagePlain = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.smoke,
                list: yesNo,
                selectedItem: smoke,
                hint: "Do you smoke?",
                onChanged: (val) => setState(() => smoke = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.halalFood,
                list: yesNo,
                selectedItem: halalFood,
                hint: "Do you prefer halal food?",
                onChanged: (val) => setState(() => halalFood = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.hijab,
                list: yesNo,
                selectedItem: hijab,
                hint: "Hijab preference",
                onChanged: (val) => setState(() => hijab = val),
              ),
              _buildDropdown(
                context,
                label: StringManager.beardMan,
                list: yesNo,
                selectedItem: beardMan,
                hint: "Beard preference",
                onChanged: (val) => setState(() => beardMan = val),
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildDropdown(
      BuildContext context, {
        required String label,
        required List<String> list,
        required String? selectedItem,
        required String hint,
        required void Function(String?) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(context, label),
        widget.dimens.k3.verticalBoxPadding,
        CustomDropDown<String>(
          list: list,
          selectedItem: selectedItem,
          hintText: hint,
          onChanged: onChanged,
        ),
        widget.dimens.k10.verticalBoxPadding,
      ],
    );
  }
  void _updateFilteredInterests(String value) {
    final apiList = newDocVM.lifeStyleModel.data?.lifeStyleAndInterest
        ?.map((e) => e.name ?? '')
        .toList() ??
        [];

    setState(() {
      filteredInterests = apiList
          .where((i) =>
      i.toLowerCase().contains(value.toLowerCase()) &&
          !selectedInterests.contains(i))
          .toList();
    });
  }
  Widget _label(BuildContext context, String text) => Text(
    text,
    style: context.textTheme.bodySmall?.copyWith(
        color: ColorManager.fieldHintColor,
        fontWeight: FontWeight.w500,
        fontSize: 13.0),
  );
  @override
  onError(String error) => MyToast.showToast(message: error);
}