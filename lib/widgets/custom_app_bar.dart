import 'package:flutter/material.dart';
import '../../application/app_theme/color_scheme.dart';
import '../../application/app_theme/text_themes.dart';

class CustomAppBar extends PreferredSize {
  final Widget? leadingWidget;
  final bool isLeadingWidget;
  final BuildContext? context;
  final List<Widget>? actionWidget;
  final String? title;
  final Widget? titleWidget;
  final PreferredSizeWidget? bottomWidget;
  final bool isCenterTitle;
  final double toolBarSize;
  final double? elevation;

  CustomAppBar(
      {super.key,
      this.leadingWidget,
      this.isLeadingWidget = false,
      this.isCenterTitle = false,
      this.titleWidget,
      this.actionWidget,
      this.elevation,
      this.bottomWidget,
      this.toolBarSize = kToolbarHeight,
      this.title,
      this.context})
      : super(
            preferredSize: Size.fromHeight(bottomWidget != null ? (bottomWidget.preferredSize.height + toolBarSize) : toolBarSize),
            child: AppBar(
                elevation: elevation ?? 0.0,
                toolbarHeight: toolBarSize,
                backgroundColor: ColorManager.primary,
                leadingWidth: leadingWidget == null ? 80 : kToolbarHeight,
                automaticallyImplyLeading: false,
                leading: leadingWidget,
                centerTitle: isCenterTitle,
                actions: actionWidget,
                bottom: bottomWidget,
                title: titleWidget ??
                    Text(
                      title ?? '',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, fontFamily: primaryFont,color: Colors.white),
                    ),));
}
