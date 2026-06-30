import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../constants/asset_manager.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_field.dart';
import 'signup_form_data.dart';

class StepOneView extends BaseStateFullWidget {
  final SignUpFormData formData;

   StepOneView({super.key, required this.formData});

  @override
  State<StepOneView> createState() => _StepOneViewState();
}

class _StepOneViewState extends State<StepOneView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: StringManager.firstName,
              style: context.textTheme.bodySmall?.copyWith(
                color: ColorManager.fieldHintColor,
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
              children: [
                TextSpan(
                  text: " *",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorManager.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          CustomField(
            hintText: StringManager.enterFirstName,
            keyboardType: TextInputType.text,
            // ✅ Uses shared formData controller
            controller: widget.formData.firstNameController,
            validator: (input) => AppValidators.fieldValidator(input),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              text: StringManager.genderName,
              style: context.textTheme.bodySmall?.copyWith(
                color: ColorManager.fieldHintColor,
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
              children: [
                TextSpan(
                  text: " *",
                  style: context.textTheme.bodySmall
                      ?.copyWith(color: ColorManager.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _genderItem(
                context: context,
                gender: Gender.male,
                title: 'Male',
                icon: Assets.male,
              ),
              const SizedBox(width: 15),
              _genderItem(
                context: context,
                gender: Gender.female,
                title: 'Female',
                icon: Assets.feMale,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderItem({
    required BuildContext context,
    required Gender gender,
    required String title,
    required String icon,
  }) {
    final bool isSelected = widget.formData.selectedGender == gender;
    return GestureDetector(
      onTap: () {
        setState(() {
          // ✅ Writes directly into shared formData
          widget.formData.selectedGender = gender;
        });
      },
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
            Image.asset(
              icon,
              height: 17,
              width: 17,
              color: isSelected
                  ? ColorManager.primary
                  : ColorManager.fieldTextColor,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? ColorManager.primary
                    : ColorManager.fieldTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}