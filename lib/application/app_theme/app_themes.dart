import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/text_themes.dart';


import 'color_scheme.dart';

ThemeData get lightTheme => ThemeData.light().copyWith(
    brightness: Brightness.light,
    datePickerTheme: DatePickerThemeData(
      confirmButtonStyle: ButtonStyle(textStyle: WidgetStateProperty.all(textTheme.titleLarge?.copyWith(color: ColorManager.primary))),
      cancelButtonStyle: ButtonStyle(textStyle: WidgetStateProperty.all(textTheme.titleLarge?.copyWith(color: ColorManager.primary))),
    ),
    colorScheme:
        const ColorScheme.light(primary: ColorManager.primary, brightness: Brightness.light, surfaceContainerHighest: Colors.transparent),
    textTheme: textTheme,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: ColorManager.textColor),
    inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: ColorManager.white,
        labelStyle: textTheme.bodyMedium!.copyWith(color: ColorManager.textColor),
        hintStyle: textTheme.bodySmall!.copyWith(color: ColorManager.border),
        floatingLabelStyle: textTheme.bodyMedium!.copyWith(color: ColorManager.primary),
        errorStyle: textTheme.labelLarge!.copyWith(color: ColorManager.radish[50], height: 0.6),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ColorManager.textColor, width: 1)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ColorManager.border, width: 1)),
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: ColorManager.border, width: 1)),
        errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: ColorManager.radish[50]!, width: 1))),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(textTheme.bodyLarge!),
        backgroundColor: WidgetStateProperty.resolveWith((states) => ColorManager.primary.withOpacity(0.3)),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
        shape: WidgetStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: ColorManager.primary))),
        foregroundColor: WidgetStateProperty.resolveWith((states) => ColorManager.white),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(textTheme.bodyLarge!),
        backgroundColor: WidgetStateProperty.resolveWith((states) => ColorManager.primary),
        padding: WidgetStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.symmetric(horizontal: 18, vertical: 12)),
        shape: WidgetStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        )),
        foregroundColor: WidgetStateProperty.resolveWith((states) => ColorManager.white),
      ),
    ),
    dividerTheme: const DividerThemeData(color: ColorManager.border, thickness: 1),
    disabledColor: ColorManager.border,
    scaffoldBackgroundColor: ColorManager.white,
    appBarTheme: const AppBarTheme(surfaceTintColor: ColorManager.primary));
