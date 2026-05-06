import 'package:flutter/cupertino.dart';

import '../../../base/base_widget.dart';
import 'auth_view_model.dart';

mixin class AuthMixin<T extends BaseStateFullWidget> {
  bool remember = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get validate => formKey.currentState!.validate();

  late AuthViewModel authVM;

  bool passVisibility = false;
  bool confirmPassVisibility = false;

  // TextEditingController email = TextEditingController(text: "malik4@gmail.com");
  // TextEditingController password = TextEditingController(text: "Test@123");

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController identityNo = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController iccid = TextEditingController();
  TextEditingController nationality = TextEditingController();
}
