import 'package:batchiq_app/features/home/widgets/timeline_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodaysTimeline extends StatelessWidget {
  const TodaysTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        DateFormat('EEE, MMM d, yyyy').format(DateTime.now());

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
        const SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 16),
              TimelineCard(
                time: "08:00-09:30AM",
                room: "ROOM 101",
                title: "CSE 101 - Introduction to Programming",
                status: "COMPLETE CLASS",
              ),
              SizedBox(width: 16),
              TimelineCard(
                time: "10:00-11:30AM",
                room: "ROOM 202",
                title: "CSE 202 - Data Structures and Algorithms",
                status: "ONGOING CLASS",
              ),
              SizedBox(width: 16),
              TimelineCard(
                time: "01:00-02:30PM",
                room: "ROOM 303",
                title: "CSE 303 - Operating Systems",
                status: "UPCOMING CLASS",
              ),
              SizedBox(width: 16),
            ],
          ),
        )
      ],
    );
  }
}
