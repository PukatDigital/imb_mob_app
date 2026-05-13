import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/explore/explore_model_view_model.dart';
import 'package:ideal_marriage_bureau/widgets/primary_button.dart';
import 'package:provider/provider.dart';

import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../base/base_widget.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/loader.dart';
import '../auth/auth_mixin.dart';

class FilterExploreBottomView extends BaseStateFullWidget {
  final Map<String, dynamic> initialParams;
   FilterExploreBottomView({super.key,  required this.initialParams,});

  @override
  State<FilterExploreBottomView> createState() =>
      _FilterExploreBottomViewState();
}

class _FilterExploreBottomViewState
    extends State<FilterExploreBottomView>
    with AuthMixin
    implements Result, ErrorResult  {
  String? age;
  String? location;
  String? maritalStatus;
  String? children;
  String? religion;
  String? education;
  String? caste;
  String? ethnicity;

  final List<String> ages = ["18-25", "26-30", "31-35", "36+"];
  String? selectedAge;
  int? ageFrom;
  int? ageTo;

  final List<String> childrenList = ["Yes", "No"];

  late ExploreViewModel exploreData;

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final vm = context.read<ExploreViewModel>();

       vm.getAllCasteData(this);
       vm.getAllEducationData(this);
       vm.getAllEthnicitiesData(this);
       vm.getAllReligionsData(this);
       vm.getAllMartialStatusData(this);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<ExploreViewModel>(
      builder: (context, provider, child) {
        exploreData = provider;

        return exploreData.apiResponse is Loading
            ? Center(child: Loader())
            : GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.black54,
            child: GestureDetector(
              onTap: () {},
              child: Stack(
                children: [
                  Positioned(
                    top: size.height * 0.24,
                    left: widget.dimens.k20,
                    right: widget.dimens.k20,
                    child: Container(
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                        color: ColorManager.white.withOpacity(.5),
                        borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(widget.dimens.k25),
                          topRight:
                          Radius.circular(widget.dimens.k25),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: size.height * 0.75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorManager.white,
                        borderRadius: BorderRadius.only(
                          topLeft:
                          Radius.circular(widget.dimens.k25),
                          topRight:
                          Radius.circular(widget.dimens.k25),
                        ),
                      ),
                      child: _buildContent(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 15),

            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            widget.dimens.k15.verticalBoxPadding,

            Text(
              "Filter",
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: widget.dimens.k17,
                fontWeight: FontWeight.w600,
                color: ColorManager.textColor,
              ),
            ),

            widget.dimens.k20.verticalBoxPadding,

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// AGE
                    _label("Age"),


                    CustomDropDown<String>(
                      list: ages,
                      selectedItem: selectedAge,
                      hintText: "Select age",
                      onChanged: (val) {
                        setState(() {
                          selectedAge = val;

                          if (val != null) {
                            if (val.contains("-")) {
                              final parts = val.split("-");

                              ageFrom = int.tryParse(parts[0]);
                              ageTo = int.tryParse(parts[1]);
                            } else if (val == "36+") {
                              ageFrom = 36;
                              ageTo = 60;
                            }
                          }
                        });
                      },
                    ),

                    widget.dimens.k10.verticalBoxPadding,

                    /// LOCATION
                    _label("Location"),

                    CustomDropDown<String>(
                      list: exploreData
                          .ethnicitiesModel.data?.ethnicities
                          ?.map((e) => e.name ?? '')
                          .toList() ??
                          [],
                      selectedItem: ethnicity,
                      hintText: "Select ethnicity",
                      onChanged: (val) =>
                          setState(() => ethnicity = val),
                    ),

                    widget.dimens.k10.verticalBoxPadding,



                    /// CASTE
                    _label("Caste"),

                    CustomDropDown<String>(
                      list: exploreData
                          .castesModel.data?.castes
                          ?.map((e) => e.name ?? '')
                          .toList() ??
                          [],
                      selectedItem: caste,
                      hintText: "Select caste",
                      onChanged: (val) =>
                          setState(() => caste = val),
                    ),

                    widget.dimens.k10.verticalBoxPadding,

                    /// ETHNICITY


                    /// MARITAL STATUS
                    _label("Marital Status"),

                    CustomDropDown<String>(
                      list: exploreData
                          .martialStatuses.data?.martialStatuses
                          ?.map((e) => e.name ?? '')
                          .toList() ??
                          [],
                      selectedItem: maritalStatus,
                      hintText: "Select status",
                      onChanged: (val) => setState(
                              () => maritalStatus = val),
                    ),

                    widget.dimens.k10.verticalBoxPadding,

                    /// CHILDREN
                    _label("Children"),

                    CustomDropDown<String>(
                      list: childrenList,
                      selectedItem: children,
                      hintText: "Select children",
                      onChanged: (val) =>
                          setState(() => children = val),
                    ),

                    widget.dimens.k10.verticalBoxPadding,

                    /// RELIGION
                    _label("Religion"),

                    CustomDropDown<String>(
                      list: exploreData
                          .religionsModel.data?.religions
                          ?.map((e) => e.name ?? '')
                          .toList() ??
                          [],
                      selectedItem: religion,
                      hintText: "Select religion",
                      onChanged: (val) =>
                          setState(() => religion = val),
                    ),

                    widget.dimens.k10.verticalBoxPadding,

                    /// EDUCATION
                    _label("Education"),

                    CustomDropDown<String>(
                      list: exploreData
                          .educationModel.data?.education
                          ?.map((e) => e.name ?? '')
                          .toList() ??
                          [],
                      selectedItem: education,
                      hintText: "Select education",
                      onChanged: (val) =>
                          setState(() => education = val),
                    ),

                    widget.dimens.k30.verticalBoxPadding,
                  ],
                ),
              ),
            ),

            /// BUTTONS
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        selectedAge = null;
                        ageFrom = null;
                        ageTo = null;
                        location = null;
                        maritalStatus = null;
                        children = null;
                        religion = null;
                        education = null;
                        caste = null;
                        ethnicity = null;
                      });
                    },
                    childText: 'Reset',
                    issquare: true,
                    color: ColorManager.primary.withOpacity(.2),
                    height: 55,
                    radius: 28,
                    textStyle:
                    context.textTheme.titleMedium!.copyWith(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                widget.dimens.k8.horizontalBoxPadding,

                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "age_from": ageFrom?.toString() ?? "",
                        "age_to": ageTo?.toString() ?? "",
                        "location": location ?? "",
                        "marital_status": maritalStatus ?? "",
                        "children": children ?? "",
                        "religion": religion ?? "",
                        "education": education ?? "",
                        "caste": caste ?? "",
                        "ethnicity": ethnicity ?? "",
                      });
                    },
                    childText: 'Apply',
                    issquare: true,
                    color: ColorManager.primary,
                    height: 55,
                    radius: 28,
                    textStyle:
                    context.textTheme.titleMedium!.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            widget.dimens.k15.verticalBoxPadding,
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          color: ColorManager.fieldHintColor,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  @override
  onError(String error) {}

  @override
  onSuccess(result) {}
}