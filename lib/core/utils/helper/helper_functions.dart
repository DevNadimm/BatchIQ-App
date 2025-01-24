import 'package:intl/intl.dart';

class HelperFunctions {
  HelperFunctions._();

  static String getDayName() {
    final now = DateTime.now();
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[now.weekday % 7];
  }

  static DateTime parseTime(String time) {
    final dateFormat = DateFormat('hh:mm a');
    try {
      time = time.trim();
      return dateFormat.parse(time);
    } catch (e) {
      throw FormatException("Error parsing time: $time. Please ensure it is in the format 'hh:mm AM/PM'.");
    }
  }

  static String getClassStatus(String startTime, String endTime) {
    final now = DateTime.now();

    final startDateTime = parseTime(startTime).copyWith(
      year: now.year,
      month: now.month,
      day: now.day,
    );
    final endDateTime = parseTime(endTime).copyWith(
      year: now.year,
      month: now.month,
      day: now.day,
    );

    if (now.isAfter(endDateTime)) {
      return 'Finished';
    } else if (now.isAfter(startDateTime) && now.isBefore(endDateTime)) {
      return 'Ongoing';
    } else {
      return 'Upcoming';
    }
  }
}
