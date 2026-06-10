import 'package:flutter/material.dart';

enum Gender { male, female }

class SignUpFormData {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  int termsAccepted = 0; // ✅ 0 = not accepted, 1 = accepted
  Gender? selectedGender;
  String? selectedQualification;
  String? selectedCountry;
  String? selectedCity;

  void dispose() {
    firstNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  bool get isStepOneValid =>
      firstNameController.text.trim().isNotEmpty && selectedGender != null;

  bool get isStepTwoValid =>
      selectedQualification != null &&
          selectedCountry != null &&
          selectedCity != null;

  bool get isStepThreeValid =>
      passwordController.text.trim().isNotEmpty &&
          passwordController.text.trim() == confirmPasswordController.text.trim() &&
          termsAccepted == 1; // ✅ 1 = accepted

  Map<String, dynamic> toJson(String email) => {
    "email": email,
    "full_name": firstNameController.text.trim(),
    "gender": selectedGender == Gender.male ? "Male" : "Female",
    "qualification": selectedQualification ?? "",
    "country": selectedCountry ?? "",
    "city": selectedCity ?? "",
    "password": passwordController.text.trim(),
    "terms_and_conditions": termsAccepted, // ✅ 1 jaye ga API ko jab accepted
  };
}