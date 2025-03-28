import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/announcement_type_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/shared/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController message = TextEditingController();
  final TextEditingController date = TextEditingController();
  final TextEditingController selectedAnnouncementType = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? selectedDate;

  bool sendNotification = false;
  bool addToCalendar = false;

  Future<void> _pickDeadline(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        date.text = DateFormat("MMM d, yyyy").format(selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Announcement",
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
                    hintText: "Enter the announcement title",
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the announcement title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: message,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Enter the announcement message",
                    labelText: "Message",
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the announcement message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  readOnly: true,
                  controller: selectedAnnouncementType,
                  decoration: InputDecoration(
                    hintText: "Announcement Type",
                    hintStyle: TextStyle(
                      color: secondaryFontColor.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () {
                    showCustomBottomSheet(
                      items: announcementType,
                      controller: selectedAnnouncementType,
                      title: "Choose Announcement Type",
                    );
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an announcement type';
                    }
                    return null;
                  },
                ),
                if (addToCalendar)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: date,
                        keyboardType: TextInputType.text,
                        readOnly: true,
                        onTap: () => _pickDeadline(context),
                        decoration: InputDecoration(
                          hintText: "Event Date",
                          hintStyle: TextStyle(
                            color: secondaryFontColor.withOpacity(0.9),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          suffixIcon: const Icon(HugeIcons.strokeRoundedCalendar03),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select date';
                          } else if (selectedDate == null) {
                            return 'Invalid date';
                          }
                          return null;
                        },
                      ),
                    ],
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
                GetBuilder<AnnouncementController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await createAnnouncement();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                        child: const Text(
                          "Create Announcement",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
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

  Future<void> createAnnouncement() async {
    final AnnouncementController announcementController = AnnouncementController.instance;

    final isSuccess = await announcementController.createAnnouncements(
      title: title.text,
      sendNotification: sendNotification,
      addToCalendar: addToCalendar,
      message: message.text,
      type: selectedAnnouncementType.text.toLowerCase(),
      date: date.text,
    );

    if (isSuccess) {
      SnackBarMessage.successMessage("Your announcement has been created successfully!");
      title.clear();
      message.clear();
      date.clear();
      selectedAnnouncementType.clear();
      sendNotification = false;
      addToCalendar = false;
      final controller = AnnouncementController.instance;
      await controller.getAnnouncements();
    } else {
      SnackBarMessage.errorMessage(announcementController.errorMessage ?? "Something went wrong!");
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
}
