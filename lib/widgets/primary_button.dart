import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../application/app_theme/color_scheme.dart';
import '../../base/base_widget.dart';

class PrimaryButton extends BaseStateLessWidget {
  final VoidCallback? onPressed;
  final Widget? child;
  final String? childText;
  final Color? color;
  final Color? borderColor;
  final TextStyle? textStyle;
  final double? width;
  final double? elevation;
  final bool isSafeArea;
  final bool issquare;
  final double? height;
  final double? radius;
  final bool isDisabled; // ✅ ADD THIS

  PrimaryButton({
    super.key,
    this.onPressed,
    this.child,
    this.childText,
    this.textStyle,
    this.color,
    this.width,
    this.borderColor,
    this.elevation,
    this.isSafeArea = true,
    this.issquare = false,
    this.height,
    this.radius,
    this.isDisabled = false, // ✅ default false (optional)
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? dimens.k55;
    final double borderRadius = radius ?? dimens.k25;

    // ✅ isDisabled true ho to null, warna normal onPressed
    final VoidCallback? effectiveOnPressed = isDisabled ? null : onPressed;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      bottom: isSafeArea && Platform.isIOS,
      child: ElevatedButton(
        onPressed: effectiveOnPressed,
        style: ElevatedButton.styleFrom(
          // ✅ isDisabled ho to opacity 0.5
          backgroundColor: isDisabled
              ? (color ?? ColorManager.primary).withOpacity(0.5)
              : (color ?? ColorManager.primary),
          disabledBackgroundColor: (color ?? ColorManager.primary).withOpacity(0.5), // ✅ jab onPressed null ho
          disabledForegroundColor: ColorManager.white,
          elevation: elevation ?? 0,
          fixedSize: Size(width ?? context.width, buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
        ),
        child: Center(
          child: child ?? Text(childText ?? '', style: textStyle),
        ),
      ),
    );
  }
}