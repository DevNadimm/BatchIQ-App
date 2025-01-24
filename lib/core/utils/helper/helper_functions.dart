import 'package:intl/intl.dart';

class HelperFunctions {
  HelperFunctions._();

  String getDayName() {
    final now = DateTime.now();
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[now.weekday % 7];
  }

  DateTime parseTime(String time) {
    final dateFormat = DateFormat.jm(); // Format -> 09:00 AM
    return dateFormat.parse(time);
  }

  String getClassStatus(String startTime, String endTime) {
    final now = DateTime.now();
    final startDateTime = parseTime(startTime);
    final endDateTime = parseTime(endTime);

    if (now.isAfter(endDateTime)) {
      return 'Finished';
    } else if (now.isAfter(startDateTime) && now.isBefore(endDateTime)) {
      return 'Ongoing';
    } else {
      return 'Upcoming';
    }
  }
}