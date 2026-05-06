import 'package:flutter/material.dart';
import '../../../application/app_theme/color_scheme.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final VoidCallback? onTap;
  final Color? backgroundColor;// Correctly typed callback
  final Color? imagesColor;// Correctly typed callback

  const ActionButton({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor,// optional callback
    this.imagesColor,// optional callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // assign the callback here
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor ?? ColorManager.white.withOpacity(.3),
        ),
        child: Image.asset(
          icon,
          height: 24,
          width: 24,
          color: imagesColor ?? ColorManager.white,
          // color: ColorManager.white,
        ),
      ),
    );
  }
}
