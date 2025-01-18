import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat("MMM dd, yyyy").format(parsedDate);
  }
}
