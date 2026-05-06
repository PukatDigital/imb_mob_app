import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../application/app_theme/color_scheme.dart';
import '../../application/app_theme/text_themes.dart';
import '../../base/base_widget.dart';

class CustomDropDown<T> extends BaseStateLessWidget {
  final List<T> list;
  final T? selectedItem;
  final String? hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final T? prefix;

  final bool? isExpanded;

  CustomDropDown(
      {super.key,
      required this.list,
      required this.selectedItem,
      required this.hintText,
      this.isExpanded,
      this.validator,
      this.onChanged,
      this.prefix});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child:
      DropdownButtonFormField2<T>(
        isExpanded: isExpanded ?? true,
        decoration: InputDecoration(
          prefixIcon: prefix != null
              ? Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(prefix as String),
          )
              : null,
          prefixIconConstraints: const BoxConstraints(maxHeight: 30, maxWidth: 30),
          contentPadding: const EdgeInsets.all(15),
          filled: true,
          fillColor: Colors.transparent, // transparent background
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
          style: context.textTheme.bodyMedium!.copyWith(
            color: ColorManager.fieldTextColor,
          ),
        ),
        style: textTheme.bodyMedium,
        items: list
            .map((item) => DropdownMenuItem<T>(
          value: item,
          child: Text(
            getText(item),
            style: context.textTheme.bodySmall!.copyWith(
              color: ColorManager.textColorSubTitle,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ))
            .toList(),
        value: selectedItem,
        validator: validator,
        onChanged: onChanged,
        isDense: true,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: Colors.transparent, // transparent button background
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        iconStyleData: const IconStyleData(
          openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded, color: ColorManager.fieldTextColor),
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: ColorManager.fieldTextColor),
          iconSize: 24,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: context.getHeight(0.3),
          isOverButton: false,
          decoration: BoxDecoration(
            color: Colors.white, // transparent dropdown background
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
          overlayColor: WidgetStateProperty.all<Color>(
            Colors.transparent, // transparent hover overlay
          ),
        ),
      ),

    );
  }

  String getText(type) {
    if (type is String) {
      return type;
    } else {
      return '';
    }
  }
}

