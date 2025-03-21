import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/constants/resource_type_list.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/resource_controller.dart';
import 'package:batchiq_app/shared/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class CreateResourcesScreen extends StatefulWidget {
  const CreateResourcesScreen({super.key});

  @override
  State<CreateResourcesScreen> createState() => _CreateResourcesScreenState();
}

class _CreateResourcesScreenState extends State<CreateResourcesScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<Map<String, String>> courseList = [];
  String? selectedType;
  bool isSendNotification = false;

  @override
  void initState() {
    fetchCourseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Resource",
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
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "File upload is unavailable. Please use Google Drive or another cloud service and provide the URL.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: titleController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter the resource title",
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the resource title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Enter the resource description",
                    labelText: "Description",
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  controller: courseController,
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
                      items: courseList.map((course) => course['name']!).toList(),
                      controller: courseController,
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
                  readOnly: true,
                  controller: typeController,
                  decoration: InputDecoration(
                    hintText: "Resource Type",
                    hintStyle: TextStyle(
                      color: secondaryFontColor.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    showCustomBottomSheet(
                      items: resourceType,
                      controller: typeController,
                      title: "Choose Resource Type",
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a resource type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: urlController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Add a URL",
                    labelText: "URL",
                    suffixIcon: IconButton(
                      icon: const Icon(HugeIcons.strokeRoundedFilePaste),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data?.text != null) {
                          urlController.text = data!.text!;
                        }
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the resource URL';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: primaryColor.withOpacity(0.4),
                    ),
                  ),
                  value: isSendNotification,
                  onChanged: (value) {
                    setState(() {
                      isSendNotification = value;
                    });
                  },
                  title: Text(
                    "Send Notification",
                    style: TextStyle(
                      color: secondaryFontColor.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                GetBuilder<ResourceController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await createResource();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                        child: const Text(
                          "Create Resource",
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

  Future<void> fetchCourseList () async {
    final controller = CourseController.instance;
    await controller.getCourses();
    courseList = controller.courses.map((course) => {
      'name': course.courseName,
      'code': course.courseCode
    }).toList();
  }

  Future<void> createResource() async {
    final course = courseList.firstWhere((course) => courseController.text == course['name']);
    String courseCode = course['code'] ?? "";
    debugPrint("Selected Course Code => $courseCode");

    final controller = ResourceController.instance;
    final result = await controller.createResource(
      title: titleController.text,
      description: descriptionController.text,
      courseName: courseController.text,
      courseCode: courseCode,
      resourcesType: typeController.text,
      url: urlController.text,
      sendNotification: isSendNotification,
    );

    if (result) {
      SnackBarMessage.successMessage("Your resource has been created successfully!");
      titleController.clear();
      descriptionController.clear();
      courseController.clear();
      typeController.clear();
      urlController.clear();

      final controller = ResourceController.instance;
      await controller.getResources();
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
