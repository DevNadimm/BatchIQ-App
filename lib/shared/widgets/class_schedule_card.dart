import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/class_schedule_model.dart';
import 'package:batchiq_app/shared/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class ClassScheduleCard extends StatelessWidget {
  final ClassScheduleModel classSchedule;
  final bool isAdmin;

  const ClassScheduleCard({
    super.key,
    required this.classSchedule,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .75,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.5,
          // color: Colors.grey.withOpacity(0.7),
          color: primaryColor.withOpacity(0.1),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "${classSchedule.courseCode} - ${classSchedule.courseName}",
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            topRow(
              context,
              "${classSchedule.startTime} - ${classSchedule.endTime}",
              HugeIcons.strokeRoundedTime03,
            ),
            const SizedBox(height: 10),
            topRow(
              context,
              classSchedule.location,
              HugeIcons.strokeRoundedMeetingRoom,
            ),
            isAdmin ? const SizedBox.shrink() : const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: topRow(
                    context,
                    classSchedule.teacher,
                    HugeIcons.strokeRoundedTeaching,
                  ),
                ),
                isAdmin
                    ? TextButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => DeleteDialog(
                              onTap: () {
                                deleteClassSchedule();
                                Get.back();
                              },
                            ),
                          );
                        },
                        label: const Row(
                          children: [
                            Icon(
                              HugeIcons.strokeRoundedDelete02,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            isAdmin ? const SizedBox.shrink() : const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Future<void> deleteClassSchedule() async {
    final controller = ClassScheduleController.instance;
    final isDelete = await controller.deleteClassSchedule(classSchedule.id);
    if (isDelete) {
      SnackBarMessage.successMessage(
          "Your class schedule has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(
          controller.errorMessage ?? "Something went wrong!");
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
        Expanded(
          child: Text(
            titleText,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: secondaryFontColor),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
