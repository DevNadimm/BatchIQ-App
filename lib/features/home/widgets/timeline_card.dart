import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/features/admin_dashboard/models/class_schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:hugeicons/hugeicons.dart';

class TimelineCard extends StatelessWidget {
  final ClassScheduleModel classSchedule;

  const TimelineCard({
    super.key,
    required this.classSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .75,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          // color: Colors.grey.withOpacity(0.7),
          color: primaryColor.withOpacity(0.3)
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            topRow(
              context,
              "${classSchedule.startTime} - ${classSchedule.endTime}",
              HugeIcons.strokeRoundedTime03,
            ),
            const SizedBox(height: 4),
            topRow(
              context,
              classSchedule.location,
              HugeIcons.strokeRoundedMeetingRoom,
            ),
            const SizedBox(height: 10),
            Text(
              "${classSchedule.courseCode} - ${classSchedule.courseName}",
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            bottomRow(
              context,
              HelperFunctions.getClassStatus(
                classSchedule.startTime,
                classSchedule.endTime,
              ),
            ),
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
        size: 18,
        color: secondaryFontColor,
      ),
      const SizedBox(width: 5),
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
      case "Finished":
        return Colors.green;
      case "Ongoing":
        return Colors.blue;
      case "Upcoming":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  return Row(
    children: [
      CircleAvatar(
        backgroundColor: getStatusColor(statusText),
        radius: 6,
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
