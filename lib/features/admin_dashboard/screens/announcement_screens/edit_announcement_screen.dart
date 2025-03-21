import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAnnouncementScreen extends StatefulWidget {
  const EditAnnouncementScreen({super.key, required this.announcement});

  final AnnouncementModel announcement;

  @override
  State<EditAnnouncementScreen> createState() =>
      _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController message = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    title.text = widget.announcement.title;
    message.text = widget.announcement.message;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Edit Announcement",
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
                GetBuilder<AnnouncementController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await editAnnouncement();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: Visibility(
                        visible: !controller.isLoading,
                        replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                        child: const Text(
                          "Edit Announcement",
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

  Future<void> editAnnouncement() async {
    final AnnouncementController announcementController = AnnouncementController.instance;

    final isSuccess = await announcementController.editAnnouncements(
      title: title.text,
      message: message.text,
      docId: widget.announcement.id,
    );

    if (isSuccess) {
      SnackBarMessage.successMessage("Your announcement has been edited successfully!");
      title.clear();
      message.clear();
      final controller = AnnouncementController.instance;
      await controller.getAnnouncements();
    } else {
      SnackBarMessage.errorMessage(announcementController.errorMessage ?? "Something went wrong!");
    }
  }
}
