import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNotificationScreen extends StatefulWidget {
  const EditNotificationScreen({super.key, required this.notification});
  final NotificationModel notification;

  @override
  State<EditNotificationScreen> createState() => _EditNotificationScreenState();
}

class _EditNotificationScreenState extends State<EditNotificationScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  UserModel? user;

  @override
  void initState() {
    title.text = widget.notification.title;
    body.text = widget.notification.body;
    fetchBatchId();
    super.initState();
  }

  Future<void> fetchBatchId () async {
    final UserController userController = UserController();
    user = await userController.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Edit Notification",
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
                    hintText: "Enter the notification title",
                    labelText: "Title",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the notification title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: body,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: "Enter the notification body",
                    labelText: "Body",
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the notification body';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<NotificationController>(
                    builder: (controller) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await editNotification();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Visibility(
                          visible: !controller.isLoading,
                          replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                          child: const Text(
                            "Edit Notification",
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

  Future<void> editNotification() async {
    final NotificationController editNotificationController = NotificationController.instance;

    final isSuccess = await editNotificationController.editNotification(
      title: title.text,
      body: body.text,
      notificationId: widget.notification.id,
      batchId: user?.batchId ?? "",
    );

    if (isSuccess) {
      SnackBarMessage.successMessage("Your notification has been edited successfully!");
      title.clear();
      body.clear();
      final controller = NotificationController.instance;
      await controller.getNotifications();
    } else {
      SnackBarMessage.errorMessage(editNotificationController.errorMessage ?? "Something went wrong!");
    }
  }
}
