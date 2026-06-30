import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../application/app_theme/color_scheme.dart';
import '../../base/base_widget.dart';

class CustomField extends BaseStateFullWidget {
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final bool obscureText;
  final String? suffixIconString;
  final String? prefixIconString;

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final VoidCallback? prefixIconCallBack, suffixIconCallBack;
  final String? initialValue;
  final String? errorText;
  final Color? fillColor;
  final bool? isFilled;
  final TextEditingController? controller;
  final bool readonly;
  final bool? isDense;
  final EdgeInsetsGeometry? contentPadding;
  final double? radius;
  final bool label;
  final int? maxLines, minLines;
  final bool enable;
  final TextAlignVertical? textAlignVertical;
  final FocusNode? focusNode;
  final TextStyle? style;
  final TextStyle? hintStyle;

  final InputDecoration? inputDecoration;
  final ScrollController? scrollController;

  CustomField({
    super.key,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    required this.hintText,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.inputFormatter,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.obscureText = false,
    this.prefixIconString,
    this.suffixIconString,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.errorText,
    this.fillColor,
    this.isFilled,
    this.readonly = false,
    this.isDense,
    this.label = false,
    this.enable = true,
    this.contentPadding,
    this.prefixIconCallBack,
    this.suffixIconCallBack,
    this.radius,
    this.minLines,
    this.maxLines = 1,
    this.textAlignVertical,
    this.scrollController,
    this.prefixText,
    this.inputDecoration,
    this.style,
    this.hintStyle,
  });

  @override
  State<CustomField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _controller.addListener(() {
      if (!mounted) return; // ← this must be line 99
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // only dispose if we created it
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasText = _controller.text.isNotEmpty;

    return TextFormField(
      textAlignVertical: widget.textAlignVertical,
      controller: _controller,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      readOnly: widget.readonly,
      enabled: widget.enable,
      focusNode: widget.focusNode,
      inputFormatters: widget.inputFormatter,
      onTap: widget.onTap,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      scrollController: widget.scrollController,
      style: widget.style ?? context.textTheme.bodyMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,

      decoration: widget.inputDecoration ??
          InputDecoration(
            errorText: widget.errorText,
            errorMaxLines: 3,
            errorStyle: context.textTheme.bodySmall!.copyWith(color: ColorManager.radish[50]),
            hintText: widget.hintText,
            hintStyle: widget.hintStyle,
            hintMaxLines: 1,

            isDense: widget.isDense,
            contentPadding: const EdgeInsets.all(15),

            // ✅ Dynamic border and fill color
            filled: true,
            fillColor: hasText ? ColorManager.transparent : ColorManager.transparent,

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
              borderSide: BorderSide(color: ColorManager.fieldTextColor , width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
              borderSide: BorderSide(color: ColorManager.fieldTextColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.2),
            ),

            // ✅ Prefix / Suffix icons
            suffixIcon: (widget.suffixIconString != null
                ? widget.suffixIconString == 'assets/icons/eye.png'
                ? Icon(Icons.visibility_outlined, color: ColorManager.primary)
                : Icon(Icons.visibility_off_outlined, color: ColorManager.primary)
                : widget.suffixIcon)
                ?.onTap(onTap: widget.suffixIconCallBack),

            prefixIcon: widget.prefixIconString != null
                ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(widget.prefixIconString!, height: 20),
            )
                : widget.prefixIcon,
          ),
    );
  }
}
