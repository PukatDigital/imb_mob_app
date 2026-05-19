import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../application/app_theme/color_scheme.dart';
import '../../application/app_theme/text_themes.dart';
import '../../base/base_widget.dart';

class MiniDropDown<T> extends BaseStateLessWidget {
  final List<T> list;
  final T? selectedItem;
  final String? hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;

   MiniDropDown({
    super.key,
    required this.list,
    required this.selectedItem,
    required this.hintText,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: DropdownButtonFormField2<T>(
        isExpanded: false, // ← key: don't expand, let it be as small as needed
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.dropDownBroder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.dropDownBroder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.dropDownBroder, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
        hint: Text(
          hintText!,
          style: context.textTheme.bodySmall!.copyWith(
            color: ColorManager.fieldTextColor,
          ),
        ),
        style: textTheme.bodySmall,
        items: list
            .map(
              (item) => DropdownMenuItem<T>(
            value: item,
            child: Text(
              getText(item),
              style: context.textTheme.bodySmall!.copyWith(
                color: ColorManager.textColorSubTitle,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        )
            .toList(),
        value: selectedItem,
        validator: validator,
        onChanged: onChanged,
        isDense: true,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        iconStyleData: const IconStyleData(
          openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded,
              color: ColorManager.fieldTextColor, size: 18),
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: ColorManager.fieldTextColor, size: 18),
          iconSize: 18, // ← smaller icon for compact look
        ),
        dropdownStyleData: DropdownStyleData(
          width: 160, // ← fixed dropdown menu width (wider than the button)
          maxHeight: context.getHeight(0.3),
          isOverButton: false,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 50,
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        ),
      ),
    );
  }

  String getText(type) {
    if (type is String) return type;
    return '';
  }
}