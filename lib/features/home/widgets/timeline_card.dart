import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';

class TimelineCard extends StatelessWidget {
  final String time;
  final String room;
  final String title;
  final String status;

  const TimelineCard({
    super.key,
    required this.time,
    required this.room,
    required this.title,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .75,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          color: Colors.grey.withOpacity(0.7),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                topRow(context, time, Icons.access_time_filled_rounded),
                const SizedBox(width: 8),
                topRow(context, room, Icons.room),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            bottomRow(context, status),
          ],
        ),
      ),
    );
  }
}

Widget topRow(BuildContext context, String titleText, IconData icon) {
  return Row(
    children: [
      Icon(
        icon,
        size: 16,
        color: secondaryFontColor,
      ),
      const SizedBox(width: 4),
      Text(
        titleText,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: secondaryFontColor),
      ),
    ],
  );
}

Widget bottomRow(BuildContext context, String statusText) {
  Color getStatusColor(String status) {
    switch (status) {
      case "COMPLETE CLASS":
        return Colors.green;
      case "ONGOING CLASS":
        return Colors.blue;
      case "UPCOMING CLASS":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  return Row(
    children: [
      CircleAvatar(
        backgroundColor: getStatusColor(statusText),
        radius: 5,
      ),
      const SizedBox(width: 4),
      Text(
        statusText,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: secondaryFontColor),
      ),
    ],
  );
}
