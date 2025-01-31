import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNotificationScreen extends StatefulWidget {
  const CreateNotificationScreen({super.key});

  @override
  State<CreateNotificationScreen> createState() => _CreateNotificationScreenState();
}

class _CreateNotificationScreenState extends State<CreateNotificationScreen> {
  final TextEditingController title = TextEditingController();
  final TextEditingController body = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create Notification",
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
                    return Visibility(
                      visible: !controller.isLoading,
                      replacement: const ProgressIndicatorWidget(),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            await createNotification();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "Create Notification",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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

  Future<void> createNotification() async {
    final NotificationController createNotificationController = NotificationController.instance;

    final isSuccess = await createNotificationController.createNotification(
      title: title.text.trim(),
      type: 'notification',
      body: body.text,
    );

    if (isSuccess) {
      SnackBarMessage.successMessage("Your notification has been created successfully!");

      title.clear();
      body.clear();

      final controller = NotificationController.instance;
      await controller.getNotifications();
    } else {
      SnackBarMessage.errorMessage(createNotificationController.errorMessage ?? "Something went wrong!");
    }
  }
}
