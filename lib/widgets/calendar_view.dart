import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../base/base_widget.dart';

class CalendarView extends BaseStateLessWidget {
  DateTime? selectedDate;
  final OnDaySelected onDaySelected;
  final bool Function(DateTime day)? enabledDayPredicate;
  final bool isPrevious;

  CalendarView({super.key, this.selectedDate, required this.onDaySelected, this.enabledDayPredicate, this.isPrevious = false});

  @override
  Widget build(BuildContext context) {
    /*return TableCalendar(
      calendarFormat: CalendarFormat.month,
      daysOfWeekHeight: context.getHeight(dimens.k2.cm),
      currentDay: selectedDate,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      focusedDay: selectedDate ?? DateTime.now(),
      la  stDay: isPrevious ? DateTime.now() : DateTime(DateTime.now().year + 1, DateTime.now().month),
      firstDay: isPrevious ? DateTime(1980) : DateTime.now(),
      enabledDayPredicate: enabledDayPredicate ?? dayPredicate,
      availableGestures: AvailableGestures.all,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: const BoxDecoration(color: ColorManager.primary),
        weekendTextStyle: context.textTheme.bodyLarge!,
        outsideTextStyle: context.textTheme.bodyLarge!,
        todayTextStyle: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white),
        holidayTextStyle: context.textTheme.bodyLarge!,
        defaultTextStyle: context.textTheme.bodyLarge!,
      ),
      daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: context.textTheme.bodyMedium!, weekendStyle: context.textTheme.bodyMedium!),
      headerStyle: HeaderStyle(
        leftChevronVisible: true,
        rightChevronVisible: true,
        titleCentered: true,
        titleTextStyle: context.textTheme.titleLarge!,
        leftChevronIcon: const Icon(Icons.keyboard_arrow_left, size: 25, color: ColorManager.primary),
        rightChevronIcon: const Icon(Icons.keyboard_arrow_right, size: 25, color: ColorManager.primary),
        formatButtonVisible: false,

      ),

      onDaySelected: onDaySelected,
      headerVisible: true,

      calendarBuilders: CalendarBuilders(
          disabledBuilder: (context, date, events) {
            return null;
          },
          selectedBuilder: (context, date, events) {
            return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(dimens.k4),
                decoration: const BoxDecoration(color: ColorManager.primary, shape: BoxShape.circle),
                child: Text(date.day.toString(), style: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white)));
          },
          todayBuilder: (context, date, events) => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(dimens.k2),
              decoration: const BoxDecoration(color: ColorManager.primary, shape: BoxShape.circle),
              child: Text(date.day.toString(), style: context.textTheme.bodyLarge!.copyWith(color: ColorManager.white)))),
    );*/
    return CalendarDatePicker(
      initialDate: selectedDate ?? DateTime.now(),  // ✅ use selectedDate if available
      firstDate: isPrevious ? DateTime(1980) : DateTime.now(),
      lastDate: DateTime.now(),
      onDateChanged: (date) {
        selectedDate = date;
        onDaySelected(selectedDate!, selectedDate!);
      },
    );
  }

  bool dayPredicate(dateTime) {
    if (isPrevious) {
      return dateTime.isAfter(DateTime(1980));
    } else {
      if (dateTime.isBefore(DateTime.now()) && !dateTime.isToday()) {
        return false;
      } else {
        return true;
      }
    }
  }
}
