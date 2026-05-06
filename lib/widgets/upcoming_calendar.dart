import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../application/app_theme/color_scheme.dart';
import '../../base/base_widget.dart';

class UpcomingCalendar extends BaseStateLessWidget {
  final DateTime? selectedDate;
  final OnDaySelected onDaySelected;
  final bool? isPrevious;
  final bool Function(DateTime day)? enabledDayPredicate;

  UpcomingCalendar({super.key, this.selectedDate, required this.onDaySelected, this.enabledDayPredicate,this.isPrevious});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarFormat: CalendarFormat.month,
      daysOfWeekHeight: context.getHeight(dimens.k2.cm),
      currentDay: selectedDate,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      focusedDay: selectedDate ?? DateTime.now(),
      lastDay: DateTime(DateTime.now().year + 1, DateTime.now().month),
      firstDay: isPrevious !=null && isPrevious==true ? DateTime.utc(2000, 1, 1) :DateTime.now(),
      enabledDayPredicate: enabledDayPredicate ??
          (dateTime) {
            if (dateTime.isBefore(isPrevious!=null && isPrevious == true ? DateTime.utc(2000, 1, 1) :DateTime.now()) && !dateTime.isToday()) {
              return false;
            } else {
              return true;
            }
          },
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: const BoxDecoration(color: ColorManager.primary),
        weekendTextStyle: context.textTheme.bodyLarge!,
        outsideTextStyle: context.textTheme.bodyLarge!,
        todayTextStyle: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
        holidayTextStyle: context.textTheme.bodyLarge!,
        defaultTextStyle: context.textTheme.bodyLarge!,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: context.textTheme.bodyLarge!, weekendStyle: context.textTheme.bodyLarge!),
      headerStyle: HeaderStyle(
          leftChevronVisible: true,
          rightChevronVisible: true,
          titleCentered: true,
          titleTextStyle: context.textTheme.bodyLarge!,
          leftChevronIcon: const Icon(Icons.keyboard_arrow_left, size: 25, color: ColorManager.primary),
          rightChevronIcon: const Icon(Icons.keyboard_arrow_right, size: 25, color: ColorManager.primary),
          formatButtonVisible: false),
      onDaySelected: onDaySelected,
      calendarBuilders: CalendarBuilders(
          disabledBuilder: (context, date, events) {
            return null;
          },
          selectedBuilder: (context, date, events) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(dimens.k4),
                decoration: const BoxDecoration(color: ColorManager.border, shape: BoxShape.circle),
                child: Text(date.day.toString(), style: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white)));
          },
          todayBuilder: (context, date, events) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(dimens.k2),
              decoration: const BoxDecoration(color: ColorManager.border, shape: BoxShape.circle),
              child: Text(date.day.toString(), style: context.textTheme.bodyLarge!))),
    );
  }
}
