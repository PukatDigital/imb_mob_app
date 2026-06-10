import 'package:flutter/material.dart';
import '../../application/app_theme/color_scheme.dart';
import '../../application/common/enum.dart';
import '../../main.dart';

class MyToast {
  static showToast({
    required String message,
    TypeToast typeToast = TypeToast.normal,
  }) {
    final color = (typeToast == TypeToast.normal)
        ? ColorManager.primary
        : (typeToast == TypeToast.success)
        ? Colors.green
        : Colors.red;

    scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.only(
            bottom: 80,
            left: 16,
            right: 16,
          ),
          duration: const Duration(seconds: 3),
          content: Row(
            mainAxisSize: MainAxisSize.min, // ✅ text ke mutabiq width
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}