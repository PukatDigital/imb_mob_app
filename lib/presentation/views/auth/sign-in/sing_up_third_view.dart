import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/helper/validators.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_field.dart';
import 'signup_form_data.dart';

class StepThreeView extends BaseStateFullWidget {
  final SignUpFormData formData;

   StepThreeView({super.key, required this.formData});

  @override
  State<StepThreeView> createState() => _StepThreeViewState();
}

class _StepThreeViewState extends State<StepThreeView> {
  bool passVisibility = false;
  bool confirmPassVisibility = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Password", style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          CustomField(
            // ✅ Uses shared formData controller
            controller: widget.formData.passwordController,
            hintText: StringManager.password,
            obscureText: !passVisibility,
            suffixIcon: Icon(
              passVisibility ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.fieldTextColor,
            ),
            suffixIconCallBack: () {
              setState(() => passVisibility = !passVisibility);
            },
            validator: (input) => AppValidators.fieldValidator(input),
            maxLines: 1,
          ),
          const SizedBox(height: 20),
          Text("Confirm Password",
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          CustomField(
            // ✅ Uses shared formData controller
            controller: widget.formData.confirmPasswordController,
            hintText: StringManager.confirmPassword,
            obscureText: !confirmPassVisibility,
            suffixIcon: Icon(
              confirmPassVisibility ? Icons.visibility : Icons.visibility_off,
              color: ColorManager.fieldTextColor,
            ),
            suffixIconCallBack: () {
              setState(() => confirmPassVisibility = !confirmPassVisibility);
            },
            validator: (input) {
              if (input == null || input.isEmpty) {
                return "Confirm password is required";
              }
              if (input != widget.formData.passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}