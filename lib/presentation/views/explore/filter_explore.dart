import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/widgets/primary_button.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../widgets/custom_drop_down.dart';
import '../auth/auth_mixin.dart';
class FilterExploreBottomView extends BaseStateFullWidget {
   FilterExploreBottomView({super.key});

  @override
  State<FilterExploreBottomView> createState() =>
      _FilterExploreBottomViewState();
}
class _FilterExploreBottomViewState
    extends State<FilterExploreBottomView>
    with AuthMixin
    implements Result {
  String? age;
  String? location;
  String? maritalStatus;
  String? children;
  String? religion;
  String? education;
  final List<String> ages = ["18-25", "26-30", "31-35", "36+"];
  final List<String> locations = ["Lahore", "Karachi", "Islamabad", "Other"];
  final List<String> maritalStatuses = ["Single", "Divorced", "Widow"];
  final List<String> childrenList = ["No", "1", "2", "3+"];
  final List<String> religions = ["Islam", "Christian", "Hindu", "Other"];
  final List<String> educations = ["High School", "Bachelor's", "Master's", "PhD"];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Navigator.pop(context), // ✅ outside close
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.black54,
        child: GestureDetector(
          onTap: () {}, // prevent inside close
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
                      topLeft: Radius.circular(widget.dimens.k25),
                      topRight: Radius.circular(widget.dimens.k25),
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
                      topLeft: Radius.circular(widget.dimens.k25),
                      topRight: Radius.circular(widget.dimens.k25),
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

            /// 🔹 Scroll Area
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    _label("Age"),
                    CustomDropDown<String>(
                      list: ages,
                      selectedItem: age,
                      hintText: "Select age",
                      onChanged: (val) => setState(() => age = val),
                    ),
                    widget.dimens.k10.verticalBoxPadding,
                    _label("Location"),
                    CustomDropDown<String>(
                      list: locations,
                      selectedItem: location,
                      hintText: "Select location",
                      onChanged: (val) => setState(() => location = val),
                    ),
                    widget.dimens.k10.verticalBoxPadding,
                    _label("Marital Status"),
                    CustomDropDown<String>(
                      list: maritalStatuses,
                      selectedItem: maritalStatus,
                      hintText: "Select status",
                      onChanged: (val) =>
                          setState(() => maritalStatus = val),
                    ),
                    widget.dimens.k10.verticalBoxPadding,
                    _label("Children"),
                    CustomDropDown<String>(
                      list: childrenList,
                      selectedItem: children,
                      hintText: "Select children",
                      onChanged: (val) => setState(() => children = val),
                    ),
                    widget.dimens.k10.verticalBoxPadding,
                    _label("Religion"),
                    CustomDropDown<String>(
                      list: religions,
                      selectedItem: religion,
                      hintText: "Select religion",
                      onChanged: (val) => setState(() => religion = val),
                    ),
                    widget.dimens.k10.verticalBoxPadding,
                    _label("Education"),
                    CustomDropDown<String>(
                      list: educations,
                      selectedItem: education,
                      hintText: "Select education",
                      onChanged: (val) => setState(() => education = val),
                    ),
                    widget.dimens.k30.verticalBoxPadding,
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    onPressed: () {
                      setState(() {
                        age = null;
                        location = null;
                        maritalStatus = null;
                        children = null;
                        religion = null;
                        education = null;
                      });
                    },
                    childText: 'Reset',
                    issquare: true,
                    color: ColorManager.primary.withOpacity(.2),
                    height: 55,
                    radius: 28,
                    textStyle: context.textTheme.titleMedium!.copyWith(
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
                        "age": age,
                        "location": location,
                        "maritalStatus": maritalStatus,
                        "children": children,
                        "religion": religion,
                        "education": education,
                      });
                    },
                    childText: 'Apply',
                    issquare: true,
                    color: ColorManager.primary,
                    height: 55,
                    radius: 28,
                    textStyle: context.textTheme.titleMedium!.copyWith(
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

