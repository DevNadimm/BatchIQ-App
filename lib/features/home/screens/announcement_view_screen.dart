import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/member_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class AnnouncementViewScreen extends StatefulWidget {
  const AnnouncementViewScreen({super.key, required this.announcement});

  final AnnouncementModel announcement;

  @override
  State<AnnouncementViewScreen> createState() => _AnnouncementViewScreenState();
}

class _AnnouncementViewScreenState extends State<AnnouncementViewScreen> {
  @override
  void initState() {
    fetchSenderName();
    super.initState();
  }

  Future<void> fetchSenderName() async {
    final controller = MemberController.instance;
    await controller.getUserDataByUid(widget.announcement.createdBy);
  }

  String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('MMMM dd, yyyy • hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final announcement = widget.announcement;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Announcement",
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
            color: Colors.grey.withValues(alpha: 0.2),
            height: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                announcement.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: HelperFunctions.getAnnouncementColor(announcement.type).withValues(alpha: 0.1),
                ),
                child: Text(
                  announcement.type.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: HelperFunctions.getAnnouncementColor(announcement.type)),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  announcement.message,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedCalendar03,
                    size: 20,
                    color: secondaryFontColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      formatDate(announcement.createdAt),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: secondaryFontColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedUser,
                    size: 20,
                    color: secondaryFontColor,
                  ),
                  const SizedBox(width: 8),
                  GetBuilder<MemberController>(
                    builder: (controller) {
                      return Expanded(
                        child: Text(
                          controller.isLoading
                              ? "Loading..."
                              : controller.userData?.name ?? "N/A",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: secondaryFontColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
