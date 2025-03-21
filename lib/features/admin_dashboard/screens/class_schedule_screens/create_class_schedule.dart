import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/day_name_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/shared/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateClassScheduleScreen extends StatefulWidget {
  const CreateClassScheduleScreen({super.key});

  @override
  State<CreateClassScheduleScreen> createState() =>
      _CreateClassScheduleScreenState();
}

class _CreateClassScheduleScreenState extends State<CreateClassScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController selectedDayController = TextEditingController();
  List<Map<String, String>> courseList = [];

  @override
  void initState() {
    fetchCourseList();
    super.initState();
  }

  Future<void> _pickTime(
      BuildContext context, TextEditingController controller) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final formattedTime = pickedTime.format(context);
      controller.text = formattedTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Class Schedule",
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
                    items: courseList.map((course) => course['courseName']!).toList(),
                    controller: courseNameController,
                    title: "Choose Course",
                  );
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a course';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: locationController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter the location (e.g., Room 203)",
                  labelText: "Classroom Location",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the classroom location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => _pickTime(context, startTimeController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: startTimeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Pick the starting time",
                      labelText: "Start Time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please pick a start time';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              GestureDetector(
                onTap: () => _pickTime(context, endTimeController),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: endTimeController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Pick the ending time",
                      labelText: "End Time",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please pick an end time';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: selectedDayController,
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
                    items: days,
                    controller: selectedDayController,
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

              GetBuilder<ClassScheduleController>(
                builder: (controller) {
                  return SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await createClassSchedule();
                        }
                      },
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                        child: const Text(
                          "Create Class Schedule",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchCourseList () async {
    final controller = CourseController.instance;
    await controller.getCourses();
    courseList = controller.courses.map((course) => {
      'courseName': course.courseName,
      'courseCode': course.courseCode,
      'instructorName': course.instructorName,
    }).toList();
  }

  Future<void> createClassSchedule() async {
    final selectedCourse = courseList.firstWhere((course) => course['courseName'] == courseNameController.text);
    final controller = ClassScheduleController.instance;

    final isCreated = await controller.createClassSchedule(
      courseName: courseNameController.text,
      courseCode: selectedCourse['courseCode']!,
      teacher: selectedCourse['instructorName']!,
      location: locationController.text,
      day: selectedDayController.text,
      startTime: startTimeController.text,
      endTime: endTimeController.text,
    );

    if(isCreated){
      SnackBarMessage.successMessage("Your class schedule has been created successfully!");
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

  void clearFields () {
    courseNameController.clear();
    locationController.clear();
    startTimeController.clear();
    endTimeController.clear();
    selectedDayController.clear();
  }
}
