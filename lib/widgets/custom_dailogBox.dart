import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../application/app_theme/color_scheme.dart';

void showCustomStatusDialog({
  required BuildContext context,
  required dynamic dimens,
  required String icon,
  required String title,
  required String description,
  required String buttonText,
  required VoidCallback onPressed,
  bool barrierDismissible = false,
  Color? buttonColor,
}) {
  showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            dimens.k24,
          ),
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: dimens.k20,
        ),
        child: Padding(
          padding: EdgeInsets.all(
            dimens.k24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// Icon
              Container(
                padding: EdgeInsets.all(
                  dimens.k5,
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  icon,
                  height: dimens.k50,
                  width: dimens.k50,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(
                height: dimens.k10,
              ),

              /// Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dimens.k24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              SizedBox(
                height: dimens.k12,
              ),

              /// Description
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: dimens.k15,
                  color: Colors.grey.shade600,
                  height: 1.4,
                ),
              ),

              SizedBox(
                height: dimens.k28,
              ),

              /// Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor:
                    buttonColor ??
                        ColorManager.rejectedText,
                    padding: EdgeInsets.symmetric(
                      vertical: dimens.k16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                        dimens.k40,
                      ),
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: dimens.k16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}