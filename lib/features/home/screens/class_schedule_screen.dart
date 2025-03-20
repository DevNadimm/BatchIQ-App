import 'package:batchiq_app/core/constants/day_name_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/shared/widgets/class_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassScheduleScreen extends StatefulWidget {
  const ClassScheduleScreen({super.key});

  @override
  State<ClassScheduleScreen> createState() =>
      _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchClassSchedules();
    });
  }

  Future<void> fetchClassSchedules() async {
    final controller = ClassScheduleController.instance;
    await controller.getClassSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Class Schedules",
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
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ClassScheduleController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.isLoading,
                  replacement: const ProgressIndicatorWidget(),
                  child: controller.classSchedules.isEmpty
                      ? const EmptyList(title: "Empty Classes!")
                      : classSchedule(controller),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget classSchedule(ClassScheduleController controller) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: days
            .where((day) => controller.dayClasses(day).isNotEmpty)
            .map((day) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 8, left: 16),
              child: Text(
                day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  ...controller.dayClasses(day).map((classSchedule) => Padding(
                    padding: const EdgeInsets.only(
                      top: 4,
                      bottom: 16,
                      right: 16,
                    ),
                    child: ClassScheduleCard(
                      classSchedule: classSchedule,
                      isAdmin: false,
                    ),
                  ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        )).toList(),
      ),
    );
  }
}
