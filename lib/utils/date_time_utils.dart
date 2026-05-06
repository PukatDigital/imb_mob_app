import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime? parseDate(String? dateStr) {
    if (dateStr == null) {
      return null;
    }
    try {
      final dateFormat = DateFormat('yyyy-MM-dd');
      return dateFormat.parse(dateStr);
    } catch (e) {
      return null;
    }
  }

  static String formatDate(DateTime? date) {
    if (date == null) {
      return '-';
    }
    final dateFormat = DateFormat('MMM dd, yyyy');
    return dateFormat.format(date);
  }

  static format(String? dateStr) {
    return formatDate(parseDate(dateStr));
  }

  static DateTime isoStringToLocalDate(String dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }

  static String isoDayWithDateString(String dateTime) {
    return DateFormat('yyyy-MM-dd').format(isoStringToLocalDate(dateTime));
  }
}
