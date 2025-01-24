import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/class_schedule_screens/create_class_schedule.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassScheduleAdminScreen extends StatefulWidget {
  const ClassScheduleAdminScreen({super.key});

  @override
  State<ClassScheduleAdminScreen> createState() => _ClassScheduleAdminScreenState();
}

class _ClassScheduleAdminScreenState extends State<ClassScheduleAdminScreen> {

  @override
  void initState() {
    fetchClassSchedules();
    super.initState();
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
                  child: const SingleChildScrollView(
                    child: Column(),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Divider(
                height: 1.5,
                thickness: 1.5,
                color: Colors.grey.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () => Get.to(const CreateClassScheduleScreen()),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Create Class Schedule",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
