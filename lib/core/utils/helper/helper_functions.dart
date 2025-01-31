import 'package:flutter/material.dart';
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

  static String parseTimestamp(String timestamp) {
    final DateTime parsedDate = DateTime.parse(timestamp);
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(parsedDate);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours > 1
          ? 's'
          : ''} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else {
      return DateFormat('d MMM').format(parsedDate);
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

  static Color getEventTypeColor(String eventType, String eventDateString) {
    DateTime now = DateTime.now();
    DateTime eventDate;

    try {
      eventDate = DateFormat("MMM dd, yyyy").parse(eventDateString);
    } catch (e) {
      return Colors.grey;
    }

    if (eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day) {
      return Colors.orange;
    }

    return eventDate.isBefore(now) ? Colors.red : Colors.green;
  }

  static String getEventStatus(String eventDateString) {
    DateTime now = DateTime.now();
    DateTime eventDate;

    try {
      eventDate = DateFormat("MMM dd, yyyy").parse(eventDateString);
    } catch (e) {
      return "Unknown";
    }

    if (eventDate.year == now.year && eventDate.month == now.month && eventDate.day == now.day) {
      return "Happening Today";
    }

    return eventDate.isBefore(now) ? "Completed" : "Scheduled";
  }

  static Color getAnnouncementColor(String type) {
    switch (type.toLowerCase()) {
      case 'general':
        return Colors.blue;
      case 'reminder':
        return Colors.orange;
      case 'event':
        return Colors.green;
      case 'assignment':
        return Colors.deepPurple;
      case 'exam':
        return Colors.red;
      case 'notice':
        return Colors.teal;
      case 'task':
        return Colors.amber;
      case 'alert':
        return Colors.pinkAccent;
      default:
        return Colors.grey;
    }
  }
}
