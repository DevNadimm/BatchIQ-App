import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/exam_schedule_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/exam_schedule_model.dart';
import 'package:batchiq_app/shared/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class ExamScheduleCard extends StatelessWidget {
  final ExamScheduleModel exam;
  final bool isAdmin;

  const ExamScheduleCard({
    super.key,
    required this.exam,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 6,
              child: _buildFormattedDate(exam.scheduledDate),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Card(
                margin: EdgeInsets.zero,
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      width: 1.5, color: primaryColor.withOpacity(0.1)),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${exam.course} (${exam.courseCode})",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: HelperFunctions.getExamTypeColor(
                                exam.examType,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              exam.examType,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: HelperFunctions.getExamTypeColor(exam.examType)),
                            ),
                          ),
                          if (isAdmin)
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteDialog(
                                    onTap: () {
                                      deleteExamSchedule();
                                      Get.back();
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                HugeIcons.strokeRoundedDelete02,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormattedDate(String date) {
    final DateTime parsedDate = DateTime.parse(date);
    final String formattedDate = DateFormat('MMM dd yyyy').format(parsedDate);

    final dateParts = formattedDate.split(' ');
    if (dateParts.length < 3) {
      return Text(formattedDate);
    }
    String month = dateParts[0];
    String day = dateParts[1];
    String year = dateParts[2];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '$month $day',
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          year,
          style: TextStyle(
            fontSize: 13,
            color: secondaryFontColor,
          ),
        ),
      ],
    );
  }

  Future<void> deleteExamSchedule() async {
    final controller = ExamScheduleController.instance;
    final isDelete = await controller.deleteExamSchedule(exam.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your exam schedule has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
