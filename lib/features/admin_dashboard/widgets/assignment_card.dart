import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/admin_dashboard/models/assignment_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({super.key, required this.assignment});
  final AssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              assignment.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              assignment.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: secondaryFontColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(HugeIcons.strokeRoundedCalendar03, size: 20, color: secondaryFontColor),
                    const SizedBox(width: 4),
                    Text(
                      assignment.deadline,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryFontColor,
                      ),
                    ),
                  ],
                ),
                assignment.link.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          // On tap here
                        },
                        child: Row(
                          children: [
                            Icon(HugeIcons.strokeRoundedLink02, color: primaryColor, size: 20,),
                            const SizedBox(width: 4),
                            Text(
                              "Open Link",
                              style: TextStyle(color: primaryColor),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
