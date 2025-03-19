import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/exam_type.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/exam_schedule_controller.dart';
import 'package:batchiq_app/shared/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateExamScheduleScreen extends StatefulWidget {
  const CreateExamScheduleScreen({super.key});

  @override
  State<CreateExamScheduleScreen> createState() =>
      _CreateExamScheduleScreenState();
}

class _CreateExamScheduleScreenState extends State<CreateExamScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController examTypeController = TextEditingController();
  final TextEditingController scheduledDateController = TextEditingController();
  List<Map<String, String>> courseList = [];

  @override
  void initState() {
    fetchCourseList();
    super.initState();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        scheduledDateController.text = "$pickedDate".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Exam Schedule",
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
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                readOnly: true,
                controller: courseNameController,
                decoration: InputDecoration(
                  hintText: "Course",
                  hintStyle: TextStyle(
                    color: secondaryFontColor.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  showCustomBottomSheet(
                    items: courseList
                        .map((course) => course['courseName']!)
                        .toList(),
                    controller: courseNameController,
                    title: "Choose Course",
                  );
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: examTypeController,
                decoration: InputDecoration(
                  hintText: "Select a Day",
                  hintStyle: TextStyle(
                    color: secondaryFontColor.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  showCustomBottomSheet(
                    items: examTypes,
                    controller: examTypeController,
                    title: "Select a Day",
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a day';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: scheduledDateController,
                decoration: InputDecoration(
                  hintText: "Pick Exam Date",
                  hintStyle: TextStyle(
                    color: secondaryFontColor.withOpacity(0.9),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: _pickDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please pick a date";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              GetBuilder<ExamScheduleController>(builder: (controller) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await createExamSchedule();
                      }
                    },
                    child: Visibility(
                      visible: !controller.isLoading,
                      replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                      child: const Text(
                        "Create Exam Schedule",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCourseList() async {
    final controller = CourseController.instance;
    await controller.getCourses();
    courseList = controller.courses
        .map((course) => {
              'courseName': course.courseName,
              'courseCode': course.courseCode,
              'instructorName': course.instructorName,
            })
        .toList();
  }

  Future<void> createExamSchedule() async {
    final selectedCourse = courseList.firstWhere(
        (course) => course['courseName'] == courseNameController.text);
    final controller = ExamScheduleController.instance;

    final isCreated = await controller.createExamSchedule(
      courseName: courseNameController.text,
      courseCode: selectedCourse['courseCode']!,
      teacher: selectedCourse['instructorName']!,
      scheduledDate: scheduledDateController.text,
      examType: examTypeController.text,
    );

    if (isCreated) {
      SnackBarMessage.successMessage(
          "Your exam schedule has been created successfully!");
      clearFields();
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }

  Future<void> showCustomBottomSheet({
    required List<String> items,
    required TextEditingController controller,
    required String title,
  }) async {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CustomBottomSheetContent(
              items: items,
              controller: controller,
              title: title,
              onItemSelected: (item) {
                setState(() {
                  controller.text = item;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void clearFields() {
    courseNameController.clear();
    examTypeController.clear();
    scheduledDateController.clear();
  }
}
