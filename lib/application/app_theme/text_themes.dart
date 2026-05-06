import 'package:flutter/material.dart';

import 'color_scheme.dart';

String get primaryFont => "Mulish-Regular";

TextTheme get textTheme => TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: primaryFont),
      displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, fontFamily: primaryFont),
      displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, fontFamily: primaryFont),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontFamily: primaryFont),
      titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: primaryFont),
      titleSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, fontFamily: primaryFont),
      bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: primaryFont),
      bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, fontFamily: primaryFont),
      bodySmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: primaryFont),
      labelLarge: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, fontFamily: primaryFont),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w300, fontFamily: primaryFont),
    ).apply(displayColor: ColorManager.primary, bodyColor: ColorManager.textColor);
