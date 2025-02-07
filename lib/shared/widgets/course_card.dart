import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/course_model.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/course_screens/edit_course_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, required this.isAdmin});

  final CourseModel course;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 1.5, color: primaryColor.withOpacity(0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    course.courseName,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                if (isAdmin)
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        onTap: () {
                          Get.to(() => EditCourseScreen(course: course));
                        },
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
                          await deleteCourse();
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
                    child: const Icon(
                      HugeIcons.strokeRoundedMoreVertical,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "Course Code: ${course.courseCode}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: secondaryFontColor),
            ),
            const SizedBox(height: 8),
            Text(
              "Instructor: ${course.instructorName}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: secondaryFontColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteCourse() async {
    final controller = CourseController.instance;
    final isDelete = await controller.deleteCourse(courseId: course.id);
    if (isDelete) {
      SnackBarMessage.successMessage("The course has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
