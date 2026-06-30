import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/app_theme/text_themes.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';

import '../../base/base_widget.dart';
import '../application/app_theme/color_scheme.dart';
import '../application/app_theme/text_themes.dart';

class CalendarView extends BaseStateLessWidget {
  DateTime? selectedDate;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day)? enabledDayPredicate;
  final bool isPrevious;
  final DateTime? lastDay;

  CalendarView({
    super.key,
    this.selectedDate,
    required this.onDaySelected,
    this.enabledDayPredicate,
    this.isPrevious = false,
    this.lastDay,
  });

  @override
  Widget build(BuildContext context) {
    final DateTime minDate = isPrevious ? DateTime(1980) : DateTime.now();
    final DateTime maxDate =
        lastDay ?? (isPrevious ? DateTime.now() : DateTime(DateTime.now().year + 1, DateTime.now().month));

    return SfDateRangePicker  (
      view: DateRangePickerView.month,
      allowViewNavigation: true,
      initialSelectedDate: selectedDate ?? (lastDay ?? DateTime.now()),
      initialDisplayDate: selectedDate ?? (lastDay ?? DateTime.now()),
      minDate: minDate,
      maxDate: maxDate,
      selectionMode: DateRangePickerSelectionMode.single,
      enablePastDates: true,
      backgroundColor: Colors.white,
      headerStyle: DateRangePickerHeaderStyle(
        textAlign: TextAlign.center,
        textStyle: context.textTheme.titleLarge,
        backgroundColor: Colors.white,
      ),
      monthViewSettings: DateRangePickerMonthViewSettings(
        firstDayOfWeek: 1,
        viewHeaderStyle: DateRangePickerViewHeaderStyle( // 👈 moved in here
          textStyle: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      selectionColor: ColorManager.primary,
      todayHighlightColor: ColorManager.primary,
      selectionTextStyle: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        if (args.value is DateTime) {
          final DateTime picked = args.value as DateTime;
          if (enabledDayPredicate == null || enabledDayPredicate!(picked)) {
            selectedDate = picked;
            onDaySelected(picked, picked);
          }
        }
      },
    );
  }
}