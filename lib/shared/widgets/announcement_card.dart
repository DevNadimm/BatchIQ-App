import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/announcement_screens/edit_announcement_screen.dart';
import 'package:batchiq_app/features/home/screens/announcement_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key, required this.announcement, required this.isAdmin});

  final AnnouncementModel announcement;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AnnouncementViewScreen(announcement: announcement));
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 1.5, color: primaryColor.withOpacity(0.1)),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isAdmin)
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      position: PopupMenuPosition.under,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          onTap: () {
                            Get.to(
                              EditAnnouncementScreen(
                                announcement: announcement,
                              ),
                            );
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
                      child: const Icon(
                        HugeIcons.strokeRoundedMoreVertical,
                        color: Colors.black87,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                announcement.message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: secondaryFontColor),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        HugeIcons.strokeRoundedCalendar03,
                        size: 18,
                        color: secondaryFontColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        HelperFunctions.parseTimestamp(announcement.createdAt),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: secondaryFontColor),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: HelperFunctions.getAnnouncementColor(announcement.type),
                    ),
                    child: Text(
                      announcement.type.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
