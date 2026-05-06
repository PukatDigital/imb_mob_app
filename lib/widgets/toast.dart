import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../application/app_theme/color_scheme.dart';
import '../../application/common/enum.dart';

class MyToast {
  static showToast({required String message, TypeToast typeToast = TypeToast.normal}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: (typeToast == TypeToast.normal)
            ? ColorManager.primary
            : (typeToast == TypeToast.success)
                ? Colors.green
                : Colors.red,
        textColor: ColorManager.white,
        fontSize: 16.0);
  }
}
