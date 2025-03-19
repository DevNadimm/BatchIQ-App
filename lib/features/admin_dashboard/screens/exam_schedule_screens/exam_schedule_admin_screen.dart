import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/exam_schedule_screens/create_exam_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamScheduleAdminScreen extends StatefulWidget {
  const ExamScheduleAdminScreen({super.key});

  @override
  State<ExamScheduleAdminScreen> createState() => _ExamScheduleAdminScreenState();
}

class _ExamScheduleAdminScreenState extends State<ExamScheduleAdminScreen> {
  @override
  void initState() {
    // fetchExams();
    super.initState();
  }

  // Future<void> fetchExams() async {
  //   final controller = NotificationController.instance;
  //   await controller.getNotifications();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Exams",
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
            child: GetBuilder<NotificationController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.isLoading,
                  replacement: const ProgressIndicatorWidget(),
                  child: controller.notifications.isEmpty
                      ? const EmptyList(
                          title: "No Exams Scheduled Yet!",
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.notifications.length,
                          itemBuilder: (context, index) {
                            return SizedBox();
                          },
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
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Get.to(() => const CreateExamScheduleScreen());
                  },
                  child: const Text(
                    "Create Exam Schedule",
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
