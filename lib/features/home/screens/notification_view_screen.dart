import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationViewScreen extends StatefulWidget {
  const NotificationViewScreen({super.key, required this.notification});
  final NotificationModel notification;

  @override
  State<NotificationViewScreen> createState() => _NotificationViewScreenState();
}

class _NotificationViewScreenState extends State<NotificationViewScreen> {

  @override
  void initState() {
    markNotificationAsRead();
    super.initState();
  }

  Future<void> markNotificationAsRead () async {
    /// Fetch Batch Id & UID
    final userController = UserController();
    final user = await userController.fetchUserData();
    final batchId = user?.batchId ?? "";
    final userId = user?.uid ?? "";

    /// Mark Notification As Read
    final controller = NotificationController.instance;
    final result = await controller.markNotificationAsRead(batchId: batchId, notificationId: widget.notification.id, userId: userId);
    if(result) {
      await controller.getNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Notification",
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
    );
  }
}
