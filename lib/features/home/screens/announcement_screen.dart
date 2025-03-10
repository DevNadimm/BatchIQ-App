import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/shared/widgets/announcement_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() =>
      _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  @override
  void initState() {
    fetchAnnouncement();
    super.initState();
  }

  Future<void> fetchAnnouncement() async {
    final controller = AnnouncementController.instance;
    await controller.getAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Announcements",
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
      body: GetBuilder<AnnouncementController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: controller.announcements.isEmpty
                ? const Center(
                  child: EmptyList(
                      title: "Empty Announcement!",
                    ),
                )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.announcements.length,
                          itemBuilder: (context, index) {
                            final announcement = controller.announcements[index];
                            return AnnouncementCard(
                              announcement: announcement,
                              isAdmin: false,
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
