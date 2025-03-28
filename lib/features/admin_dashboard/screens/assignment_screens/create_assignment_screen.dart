import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/assignment_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class CreateAssignmentScreen extends StatefulWidget {
  const CreateAssignmentScreen({super.key});

  @override
  State<CreateAssignmentScreen> createState() => _CreateAssignmentScreenState();
}

class _CreateAssignmentScreenState extends State<CreateAssignmentScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController link = TextEditingController();
  final TextEditingController deadline = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime? selectedDeadline;

  bool sendNotification = false;
  bool addToCalendar = false;

  Future<void> _pickDeadline(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDeadline = pickedDate;
        deadline.text = DateFormat("MMM d, yyyy").format(selectedDeadline!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Assignment",
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
                  controller: title,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Enter the assignment title",
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the assignment title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Enter the assignment description",
                    labelText: "Description",
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the assignment description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: deadline,
                  keyboardType: TextInputType.text,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Deadline",
                    hintStyle: TextStyle(
                      color: secondaryFontColor.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    suffixIcon: const Icon(HugeIcons.strokeRoundedCalendar03),
                  ),
                  onTap: () {
                    _pickDeadline(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select deadline';
                    } else if (selectedDeadline == null) {
                      return 'Invalid deadline';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: link,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Add a link (optional)",
                    labelText: "Link (Optional)",
                    suffixIcon: IconButton(
                      icon: const Icon(HugeIcons.strokeRoundedFilePaste),
                      onPressed: () async {
                        final data = await Clipboard.getData('text/plain');
                        if (data?.text != null) {
                          link.text = data!.text!;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                /// Send Notification Switch
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: primaryColor.withOpacity(0.4),
                    ),
                  ),
                  value: sendNotification,
                  onChanged: (value) {
                    setState(() {
                      sendNotification = value;
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

                /// Add to My Calendar Switch
                SwitchListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      width: 1,
                      color: primaryColor.withOpacity(0.4),
                    ),
                  ),
                  value: addToCalendar,
                  onChanged: (value) {
                    setState(() {
                      addToCalendar = value;
                    });
                  },
                  title: Text(
                    "Add to My Calendar",
                    style: TextStyle(
                      color: secondaryFontColor.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                GetBuilder<AssignmentController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await createAssignment();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                        child: const Text(
                          "Create Assignment",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createAssignment() async {
    final AssignmentController createAssignmentController = AssignmentController.instance;

    final isSuccess = await createAssignmentController.createAssignment(
      title: title.text,
      description: description.text,
      deadline: deadline.text,
      link: link.text,
      sendNotification: sendNotification,
      addToCalendar: addToCalendar,
    );

    if (isSuccess) {
      SnackBarMessage.successMessage("Your assignment has been created successfully!");

      title.clear();
      description.clear();
      deadline.clear();
      link.clear();
      sendNotification = false;
      addToCalendar = false;

      final controller = AssignmentController.instance;
      await controller.getAssignments();
    } else {
      SnackBarMessage.errorMessage(createAssignmentController.errorMessage ?? "Something went wrong!");
    }
  }
}
