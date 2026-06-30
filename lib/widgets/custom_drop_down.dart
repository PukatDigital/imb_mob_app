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

  /// Set to false if you ever need a plain, non-searchable dropdown.
  final bool isSearchable;

  /// Placeholder text shown inside the search box.
  final String searchHintText;

  // Kept alive for the lifetime of this widget instance so the
  // dropdown_button2 package can read/clear it on open/close.
  final TextEditingController _searchController = TextEditingController();

  CustomDropDown({
    super.key,
    required this.list,
    required this.selectedItem,
    required this.hintText,
    this.isExpanded,
    this.validator,
    this.onChanged,
    this.prefix,
    this.isSearchable = true,
    this.searchHintText = "Search...",
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
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.dropDownBroder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.fieldTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: ColorManager.fieldTextColor, width: 2),
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
            color: Colors.transparent,
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
        // 🔍 Search support — applies to every dropdown using this widget
        dropdownSearchData: isSearchable
            ? DropdownSearchData<T>(
          searchController: _searchController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
            child: TextFormField(
              controller: _searchController,
              style: context.textTheme.bodySmall,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                hintText: searchHintText,
                hintStyle: context.textTheme.bodySmall?.copyWith(
                  color: ColorManager.fieldHintColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManager.dropDownBroder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManager.dropDownBroder),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: ColorManager.fieldTextColor, width: 1.5),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return getText(item.value)
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        )
            : null,
        onMenuStateChange: (isOpen) {
          // Clear search text every time the menu closes so it
          // doesn't carry over the next time it's opened.
          if (!isOpen) {
            _searchController.clear();
          }
        },
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