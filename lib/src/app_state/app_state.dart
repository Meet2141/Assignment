import 'package:intl/intl.dart';

class AppState {
  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  /// Date Formatter
  String formatDateTime({required String dateTime, String format = 'dd MMM' 'yy'}) {
    if (dateTime.isEmpty) {
      return dateTime;
    }
    DateTime dateLocalDateTime = DateTime.parse(dateTime);
    var formatter = DateFormat(format);
    return formatter.format(dateLocalDateTime);
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
