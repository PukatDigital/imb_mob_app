import '../../constants/string_manager.dart';

class AppValidators {
  AppValidators._();

  static String? fieldValidator(String? input) {
    if ((input ?? "").isEmpty) {
      return StringManager.requiredField;
    } else {
      return null;
    }
  }

  static String otpValidator(String input, String error) {
    if (error != '') {
      return error;
    } else if (input.isEmpty) {
      return "Required Field";
    } else if (input.length < 6) {
      return "Fill all required fields";
    } else {
      return '';
    }
  }

  static String? passwordValidator(String? input) {
    final RegExp regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[^A-Za-z0-9\s])[A-Za-z\d\S]{8,}$');

    if ((input ?? "").isEmpty) {
      return StringManager.requiredField;
    } else if (!regex.hasMatch(input!)) {
      return "Password should contain at least 8 characters, uppercase letter, lowercase letter, numeric character and special character";
    } else {
      return null;
    }
  }

  static String? comparePasswords(String? input, String? cInput) {
    if (cInput!.isEmpty) {
      return StringManager.requiredField;
    } else if (cInput != input) {
      return StringManager.samePassword;
    } else {
      return null;
    }
  }

  static String? mailValidator(String? input) {
    String? pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if ((input?.trim() ?? "").isEmpty) {
      return StringManager.requiredField;
    } else if (!regex.hasMatch(input!)) {
      return StringManager.validEmail;
    }
    return null;
  }

  static String? phoneValidator(String? input) {
    String? pattern = r'^(\+92)(3)([0-9]{9})$';
    RegExp regex = RegExp(pattern);
    if ((input?.trim() ?? "").isEmpty) {
      return StringManager.requiredField;
    } else if (!regex.hasMatch("+92$input")) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
