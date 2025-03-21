import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/course_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditCourseScreen extends StatefulWidget {
  const EditCourseScreen({super.key, required this.course});
  final CourseModel course;

  @override
  State<EditCourseScreen> createState() => _EditCourseScreenState();
}

class _EditCourseScreenState extends State<EditCourseScreen> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController instructorNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  late String batchId;

  @override
  void initState() {
    courseNameController.text = widget.course.courseName;
    courseCodeController.text = widget.course.courseCode;
    instructorNameController.text = widget.course.instructorName;
    fetchBatchId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Edit Course",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(backArrow),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: courseNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter the course name",
                    labelText: "Course Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: courseCodeController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter the course code",
                    labelText: "Course Code",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: instructorNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter the instructor name",
                    labelText: "Instructor Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the instructor name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<CourseController>(
                    builder: (controller) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await editCourse();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Visibility(
                          visible: !controller.isLoading,
                          replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                          child: const Text(
                            "Edit Course",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editCourse() async {
    final CourseController controller = CourseController.instance;
    final result = await controller.editCourse(
      courseName: courseNameController.text,
      courseCode: courseCodeController.text,
      instructorName: instructorNameController.text,
      batchId: batchId,
      courseId: widget.course.id,
    );

    if(result) {
      SnackBarMessage.successMessage("Your course has been edited successfully!");
      courseNameController.clear();
      courseCodeController.clear();
      instructorNameController.clear();
      final controller = CourseController.instance;
      await controller.getCourses();
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }

  Future<void> fetchBatchId () async {
    final controller = UserController();
    final user = await controller.fetchUserData();
    batchId = user?.batchId ?? "";
  }
}
