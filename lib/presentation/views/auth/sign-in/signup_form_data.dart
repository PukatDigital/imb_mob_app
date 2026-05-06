import 'package:flutter/material.dart';
import '../../set-up/tell_about_your_self.dart';


import 'package:flutter/material.dart';

// ✅ Single source of truth for Gender enum
enum Gender { male, female }

class SignUpFormData {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
          passwordController.text.trim() == confirmPasswordController.text.trim();

  Map<String, dynamic> toJson(String email) => {
    "email": email,
    "full_name": firstNameController.text.trim(),
    "gender": selectedGender == Gender.male ? "Male" : "Female",
    "qualification": selectedQualification ?? "",
    "country": selectedCountry ?? "",
    "city": selectedCity ?? "",
    "password": passwordController.text.trim(),
  };
}