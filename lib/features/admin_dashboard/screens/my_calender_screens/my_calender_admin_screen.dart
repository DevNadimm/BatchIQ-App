import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/my_calendar_event_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/widgets/timeline_event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyCalendarAdminScreen extends StatefulWidget {
  const MyCalendarAdminScreen({super.key});

  @override
  State<MyCalendarAdminScreen> createState() => _MyCalendarAdminScreenState();
}

class _MyCalendarAdminScreenState extends State<MyCalendarAdminScreen> {
  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    final controller = MyCalendarEventController.instance;
    await controller.getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "My Calendar",
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
      body: GetBuilder<MyCalendarEventController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: ProgressIndicatorWidget());
          }

          if (controller.events.isEmpty) {
            return const Center(child: EmptyList(title: "Empty Events!"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            itemCount: controller.events.length,
            itemBuilder: (context, index) {
              final event = controller.events[index];
              return TimelineEventCard(
                event: event,
                isAdmin: true,
              );
            },
          );
        },
      ),
    );
  }
}