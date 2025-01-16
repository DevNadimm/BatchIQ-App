import 'package:batchiq_app/core/utils/ui/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/get_assignment_admin_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/create_assignment_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/widgets/assignment_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentAdminScreen extends StatefulWidget {
  const AssignmentAdminScreen({super.key});

  @override
  State<AssignmentAdminScreen> createState() => _AssignmentAdminScreenState();
}

class _AssignmentAdminScreenState extends State<AssignmentAdminScreen> {
  @override
  void initState() {
    fetchAssignment();
    super.initState();
  }

  Future<void> fetchAssignment() async {
    final controller = GetAssignmentAdminController.instance;
    await controller.getAssignments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Assignment",
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
            child: GetBuilder<GetAssignmentAdminController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.isLoading,
                  replacement: const ProgressIndicatorWidget(),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.assignments.length,
                          itemBuilder: (context, index) {
                            final assignment = controller.assignments[index];
                            return AssignmentCard(assignment: assignment);
                          },
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
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
                  onPressed: () => Get.to(const CreateAssignmentScreen()),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Create Assignment",
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
