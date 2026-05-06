import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';


import '../application/app_theme/color_scheme.dart';

BoxShadow shadow = const BoxShadow(
    color: ColorManager.border,
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(
      0,
      3,
    ));

CustomDropdownDecoration customDropdownDecoration = CustomDropdownDecoration(
  closedBorderRadius: BorderRadius.circular(10),
  closedBorder: Border.all(color: ColorManager.border),
  expandedBorder: Border.all(color: ColorManager.border),
);
