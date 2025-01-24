import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/shared/buttons/custom_dropdown_button.dart';
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
  final TextEditingController courseCodeController = TextEditingController();
  final TextEditingController teacherController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String? selectedDay;

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
              // Course Name Field with Validator
              TextFormField(
                controller: courseNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter the name of the course",
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

              // Course Code Field with Validator
              TextFormField(
                controller: courseCodeController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter the course code (e.g., CSE 101)",
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

              // Teacher Name Field with Validator
              TextFormField(
                controller: teacherController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: "Enter the instructor's name",
                  labelText: "Instructor Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the instructor\'s name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Location Field with Validator
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

              // Start Time Picker with Validator
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

              // End Time Picker with Validator
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
              CustomDropdownButton<String>(
                items: days,
                selectedValue: selectedDay,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                  });
                },
                itemLabel: (item) => item,
                hintText: 'Select Day',
              ),
              const SizedBox(height: 16),

              // Submit Button
              GetBuilder<ClassScheduleController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.isLoading,
                    replacement: const ProgressIndicatorWidget(),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await createClassSchedule();
                          }
                        },
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

  Future<void> createClassSchedule() async {
    final controller = ClassScheduleController.instance;
    final isCreated = await controller.createClassSchedule(
      day: selectedDay.toString(),
      startTime: startTimeController.text,
      endTime: endTimeController.text,
      courseCode: courseCodeController.text,
      courseName: courseNameController.text,
      teacher: teacherController.text,
      location: locationController.text,
    );

    if(isCreated){
      SnackBarMessage.successMessage("Your class schedule has been created successfully!");
      clearFields();
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }

  void clearFields () {
    courseNameController.clear();
    courseCodeController.clear();
    teacherController.clear();
    locationController.clear();
    startTimeController.clear();
    endTimeController.clear();
  }
}
