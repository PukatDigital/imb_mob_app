import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../application/app_theme/color_scheme.dart';
import '../base/base_widget.dart';

class LockerDropDown<T> extends BaseStateLessWidget {
  final List<T> list;
  final T? selectedItem;
  final String? hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final T? prefix;

  final bool? isExpanded;

  LockerDropDown(
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
      child: DropdownButtonFormField2<T>(
        isExpanded: isExpanded ?? true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 15, bottom: 15, right: 5),
        ),
        hint: Text(hintText!, style: context.textTheme.bodyMedium!.copyWith(color: ColorManager.border)),
        style: context.textTheme.bodyMedium,
        items: list
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: context.textTheme.bodySmall!.copyWith(color: ColorManager.textColor),
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
        ),
        iconStyleData: const IconStyleData(
            openMenuIcon: Icon(Icons.keyboard_arrow_up_rounded, color: ColorManager.textColor),
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: ColorManager.textColor),
            iconSize: 24),
        dropdownStyleData: DropdownStyleData(
            maxHeight: context.getHeight(0.3),
            isOverButton: false,
            decoration: BoxDecoration(
              color: ColorManager.white,
              borderRadius: BorderRadius.circular(10),
            ),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(10),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            )),
        menuItemStyleData: MenuItemStyleData(
            height: 50,
            overlayColor: WidgetStateProperty.all<Color>(
              ColorManager.white,
            )),
      ),
    );
  }
}
