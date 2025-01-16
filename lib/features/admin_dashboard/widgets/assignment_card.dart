import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/assignment_admin_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/assignment_model.dart';
import 'package:batchiq_app/shared/controller/launch_url.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    assignment.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  position: PopupMenuPosition.under,
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedNoteEdit,
                            color: secondaryFontColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Edit",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: secondaryFontColor),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        await deleteAssignment();
                      },
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedDelete01,
                            color: secondaryFontColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Delete",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: secondaryFontColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(HugeIcons.strokeRoundedMoreVertical),
                )
              ],
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
                    Icon(HugeIcons.strokeRoundedCalendar03,
                        size: 20, color: secondaryFontColor,),
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
                          LaunchURL.launchURL(assignment.link);
                        },
                        child: Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedLink02,
                              color: primaryColor,
                              size: 20,
                            ),
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

  Future<void> deleteAssignment() async {
    final controller = AssignmentAdminController.instance;
    final isDelete = await controller.deleteAssignment(assignment.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your assignment has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
