import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:batchiq_app/features/home/screens/notification_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.isAdmin,
  });

  final NotificationModel notification;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          splashColor: primaryColor.withOpacity(0.1),
          leading: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Image.asset(
                  getNotificationIcon(notification.type),
                  scale: 22,
                ),
              ),
              if (!notification.read)
                Positioned(
                  right: -5,
                  top: -5,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          title: Text(
            notification.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: secondaryFontColor),
                ),
                const SizedBox(height: 04),
                Text(
                  HelperFunctions.parseTimestamp(notification.createdAt),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: secondaryFontColor),
                ),
              ],
            ),
          ),
          trailing: isAdmin
              ? PopupMenuButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  position: PopupMenuPosition.under,
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      onTap: () {
                        // Add your edit notification screen navigation logic
                      },
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedNoteEdit,
                            color: secondaryFontColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Edit",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: secondaryFontColor),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        await deleteNotification();
                      },
                      child: Row(
                        children: [
                          Icon(
                            HugeIcons.strokeRoundedDelete01,
                            color: secondaryFontColor,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Delete",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: secondaryFontColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                  child: const Icon(
                    HugeIcons.strokeRoundedMoreVertical,
                    color: Colors.black54,
                  ),
                )
              : const Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                ),
          onTap: () {
            Get.to(NotificationViewScreen(notification: notification));
          },
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        ),
        Divider(
          height: 1.5,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }

  Future<void> deleteNotification() async {
    final controller = NotificationController.instance;
    final isDelete = await controller.deleteNotification(notificationId: notification.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your notification has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }

  String getNotificationIcon(String type) {
    if (type == 'announcement') {
      return IconImageName.announcement;
    } else if (type == 'exam') {
      return IconImageName.exam;
    } else if (type == 'assignment') {
      return IconImageName.assignment;
    } else {
      return IconImageName.notification;
    }
  }
}
