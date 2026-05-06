import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../application/app_theme/color_scheme.dart';
import '../base/base_widget.dart';

class OTPCodeField extends BaseStateFullWidget {
  final void Function(String)? onCompleted;
  final bool hasError;

   OTPCodeField({
    super.key,
    this.onCompleted,
    this.hasError = false,
  });

  @override
  State<OTPCodeField> createState() => _OTPCodeFieldState();
}

class _OTPCodeFieldState extends State<OTPCodeField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: _controller,
      length: 6,
      keyboardType: TextInputType.number,
      cursorColor: ColorManager.primary,
      animationType: AnimationType.fade,
      animationDuration: const Duration(milliseconds: 200),
      showCursor: true,

      textStyle: context.textTheme.bodyLarge!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: ColorManager.secondary,
      ),

      hintCharacter: '*',
      hintStyle: context.textTheme.bodyLarge!.copyWith(
        fontSize: 33,
        fontWeight: FontWeight.w600,
        color: ColorManager.starColor,
        height: 1.9,
      ),

      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(widget.dimens.k12),
        fieldHeight: widget.dimens.k55,
        fieldWidth: widget.dimens.k50,
        activeFillColor: ColorManager.white,
        selectedFillColor: ColorManager.white,
        inactiveFillColor: ColorManager.white,
        inactiveColor: ColorManager.lightBorder,
        selectedColor: ColorManager.liteGrey,
        activeColor: widget.hasError
            ? ColorManager.primary
            : ColorManager.lightBorder,
      ),

      backgroundColor: Colors.transparent,
      enableActiveFill: true,

      onChanged: (_) {},
      onCompleted: widget.onCompleted,
    );
  }
}
