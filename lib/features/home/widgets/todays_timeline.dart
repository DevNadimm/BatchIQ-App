import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/home/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysTimeline extends StatelessWidget {
  TodaysTimeline({super.key, required this.controller});

  final ClassScheduleController controller;
  final String today = HelperFunctions.getDayName();

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('EEE, MMM d, yyyy').format(DateTime.now());
    final classesToday = controller.dayClasses(today);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "TODAY'S TIMELINE",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            formattedDate,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 16),
        if (classesToday.isNotEmpty)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 16),
                ...classesToday.map(
                  (classSchedule) => Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      bottom: 4,
                      right: 16,
                    ),
                    child: TimelineCard(
                      classSchedule: classSchedule,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "No classes today. Relax and recharge!",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
      ],
    );
  }
}
