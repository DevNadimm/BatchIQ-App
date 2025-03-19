import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/exam_schedule_controller.dart';
import 'package:batchiq_app/shared/widgets/exam_schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamScheduleScreen extends StatefulWidget {
  const ExamScheduleScreen({super.key});

  @override
  State<ExamScheduleScreen> createState() => _ExamScheduleScreenState();
}

class _ExamScheduleScreenState extends State<ExamScheduleScreen> {
  @override
  void initState() {
    fetchExams();
    super.initState();
  }

  Future<void> fetchExams() async {
    final controller = ExamScheduleController.instance;
    await controller.getExamSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Exam Schedules",
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
      body: GetBuilder<ExamScheduleController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: controller.examSchedules.isEmpty
                ? const EmptyList(
                    title: "No Exams Scheduled Yet!",
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shrinkWrap: true,
                    itemCount: controller.examSchedules.length,
                    itemBuilder: (context, index) {
                      final examSchedule = controller.examSchedules[index];
                      return ExamScheduleCard(
                        isAdmin: false,
                        exam: examSchedule,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
