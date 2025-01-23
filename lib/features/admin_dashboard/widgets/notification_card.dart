import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/formatters/date_formatters.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(width: 1.5, color: notification.read? primaryColor.withOpacity(0.1) : primaryColor.withOpacity(0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    notification.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton(
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
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(HugeIcons.strokeRoundedMoreVertical),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              notification.body,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: secondaryFontColor,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedCalendar03,
                      size: 20,
                      color: secondaryFontColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormatter.formatDate(notification.createdAt),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: secondaryFontColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blue.shade50,
                    border: Border.all(width: 1, color: Colors.blue),
                  ),
                  child: Text(
                    notification.type.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: secondaryFontColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> deleteNotification() async {
    final controller = NotificationController.instance;
    final isDelete = await controller.deleteNotification(notificationId: notification.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your notification has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(
          controller.errorMessage ?? "Something went wrong!");
    }
  }
}
