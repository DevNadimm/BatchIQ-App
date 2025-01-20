import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/formatters/date_formatters.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement});

  final AnnouncementModel announcement;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
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
                    announcement.title,
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
                        // Get.to(
                        //   EditAnnouncementScreen(
                        //     announcement: announcement,
                        //   ),
                        // );
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
                        await deleteAnnouncement();
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
                  child: const Icon(HugeIcons.strokeRoundedMoreVertical),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              announcement.message,
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
                      DateFormatter.formatDate(announcement.createdAt),
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
                    color: Colors.green.shade50,
                    border: Border.all(width: 1, color: Colors.green)
                  ),
                  child: Text(
                    announcement.type.toUpperCase(),
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

  Future<void> deleteAnnouncement() async {
    final controller = AnnouncementController.instance;
    final isDelete = await controller.deleteAnnouncements(announcement.id);
    if (isDelete) {
      SnackBarMessage.successMessage(
          "Your announcement has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(
          controller.errorMessage ?? "Something went wrong!");
    }
  }
}
