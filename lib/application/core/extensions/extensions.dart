import 'dart:io';
import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../network/result.dart';

extension SafeFirst<T> on List<T>? {
  T? get safeFirst => this?.isNotEmpty == true ? this!.first : null;
}

extension SizeExt on double {
  SizedBox get verticalBoxPadding => SizedBox(height: this);

  SizedBox get horizontalBoxPadding => SizedBox(width: this);
}

class Px {
  final double kDefaultDuration = .25;

  static const toolBar = 80.0;

  double get statusBarSize => Platform.isIOS ? 50 : 35.0;

  double get extendSizeBodyBehindAppBar => toolBar + statusBarSize;

  final kDefault = 0.0;

  final k1 = 1.0;
  final k2 = 2.0;
  final k3 = 3.0;
  final k4 = 4.0;
  final k5 = 5.0;
  final k6 = 6.0;
  final k7 = 7.0;
  final k8 = 8.0;
  final k9 = 9.0;
  final k10 = 10.0;

  final k11 = 11.0;
  final k12 = 12.0;
  final k13 = 13.0;
  final k14 = 14.0;
  final k15 = 15.0;
  final k16 = 16.0;
  final k18 = 18.0;
  final k17 = 18.0;
  final k20 = 20.0;

  final k21 = 21.0;
  final k22 = 22.0;
  final k23 = 23.0;
  final k24 = 24.0;
  final k25 = 25.0;
  final k26 = 26.0;
  final k27 = 27.0;
  final k28 = 28.0;
  final k29 = 29.0;
  final k30 = 30.0;
  final k32 = 32.0;
  final k36 = 36.0;
  final k40 = 40.0;
  final k42 = 42.0;
  final k43 = 43.0;
  final k44 = 44.0;
  final k45 = 45.0;
  final k47 = 47.0;
  final k48 = 48.0;
  final k50 = 50.0;
  final k55 = 55.0;
  final k60 = 60.0;
  final k70 = 70.0;
  final k80 = 80.0;
  final k85 = 85.0;
  final k90 = 90.0;
  final k92 = 92.0;
  final k96 = 96.0;
  final k98 = 98.0;
  final k100 = 100.0;
  final k110 = 110.0;
  final k150 = 150.0;
  final k130 = 130.0;
  final k250 = 250.0;
  final k300 = 300.0;
  final k350 = 350.0;
  final k400 = 400.0;

  double get toolBarHeight => toolBar;
}

extension Box on double {
  double get mm => this / 1000;

  double get cm => this / 100;

  double get m => this / 10;
}

extension AsyncFold<T> on List<T> {
  Future<S> asyncFold<S>(S initialValue, Future<S> Function(S previous, T element) combine) async {
    S accumulator = initialValue;
    for (T element in this) {
      accumulator = await combine(accumulator, element);
    }
    return accumulator;
  }
}

extension LetExtension<T> on T? {
  void let(void Function(T it) operation) {
    if (this != null) {
      operation(this as T);
    }
  }
}

extension ApiResponseExt on ApiResponse {
  fold<T>({
    void Function(T data)? onSuccess,
    void Function(String message)? onError,
  }) {
    if (this is Success && onSuccess != null) {
      onSuccess((this as Success).data);
    } else if (this is Error && onError != null) {
      onError((this as Error).errorMessage);
    }
  }
}

extension StringExtension on String {
  int toInt() => int.parse(this);

  double toFloat() => double.parse(this);

  String defaultOnEmpty([String defaultValue = ""]) => isEmpty ? defaultValue : this;

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension ContextExtension on BuildContext {
  // MediaQueryData get mediaQuery => MediaQueryData.fromView(View.of(this));
  double getHeight([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.height * factor;
  }

  double getWidth([double factor = 1]) {
    assert(factor != 0);
    return MediaQuery.of(this).size.width * factor;
  }

  double get height => getHeight();

  double get width => getWidth();

  TextTheme get textTheme => Theme.of(this).textTheme;

  ThemeData get theme => Theme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get size => mediaQuery.size;

  double get scale => mediaQuery.devicePixelRatio;

  RelativeRect getRelativeRect(Offset offset) {
    double left = offset.dx;
    double top = offset.dy;
    double right = offset.dx;
    double bottom = offset.dy;

    return RelativeRect.fromLTRB(left, top, right, bottom);
  }

  double gap() {
    double scale = MediaQuery.textScaleFactorOf(this);
    return scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1)) ?? 1.0;
  }
}

extension DateHelpers on DateTime {
  DateTime fromTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day && yesterday.month == month && yesterday.year == year;
  }

  DateTime firstDateOfTheWeek() {
    return subtract(Duration(days: weekday - 1));
  }

  DateTime lastDateOfTheWeek() {
    return add(Duration(days: DateTime.daysPerWeek - weekday));
  }

  bool isDateInCurrentMonth(int number) {
    DateTime currentDate = DateTime.now();
    return year == currentDate.year && (month >= (currentDate.month - number) && month <= currentDate.month);
  }

  DateTime lastDayOfMonth() => ((month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1)).subtract(const Duration(days: 1));
}

extension ClickableExtension on Widget {
  Widget onTap(
      {Key? key,
      VoidCallback? onTap,
      HitTestBehavior? behavior,
      GestureTapDownCallback? onTapDown,
      GestureDragUpdateCallback? verticalDrag}) {
    return GestureDetector(
      key: key,
      behavior: behavior ?? HitTestBehavior.opaque,
      onTap: onTap,
      onTapDown: onTapDown,
      onVerticalDragUpdate: verticalDrag,
      child: this,
    );
  }
}

extension WidgetPadding on Widget {
  Widget padding(EdgeInsets edgeInsets) {
    return Padding(
      padding: edgeInsets,
      child: this,
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  int compare(TimeOfDay other) {
    return inMinutes() - other.inMinutes();
  }

  int inMinutes() {
    return hour * 60 + minute;
  }

  bool before(TimeOfDay other) {
    return compare(other) < 0;
  }

  bool after(TimeOfDay other) {
    return compare(other) > 0;
  }

  TimeOfDay add({required int minutes}) {
    final total = inMinutes() + minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  TimeOfDay subtract({required int minutes}) {
    final total = inMinutes() - minutes;
    return TimeOfDay(hour: total ~/ 60, minute: total % 60);
  }

  bool beforeOrEqual(TimeOfDay other) {
    return compare(other) <= 0;
  }

  bool afterOrEqual(TimeOfDay other) {
    return compare(other) >= 0;
  }
}
