import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/shared/widgets/notification_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    fetchAnnouncement();
    super.initState();
  }

  Future<void> fetchAnnouncement() async {
    final controller = NotificationController.instance;
    await controller.getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Notifications",
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
      body: GetBuilder<NotificationController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: controller.notifications.isEmpty
                ? const Center(
                  child: EmptyList(
                      title: "Empty Notification!",
                    ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = controller.notifications[index];
                    return NotificationCard(
                      notification: notification,
                      isAdmin: false,
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
