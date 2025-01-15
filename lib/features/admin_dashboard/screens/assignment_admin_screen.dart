import 'package:batchiq_app/core/utils/ui/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/create_assignment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssignmentAdminScreen extends StatefulWidget {
  const AssignmentAdminScreen({super.key});

  @override
  State<AssignmentAdminScreen> createState() => _AssignmentAdminScreenState();
}

class _AssignmentAdminScreenState extends State<AssignmentAdminScreen> {
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
          const Expanded(
            child: Center(child: Text("Assignment")),
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
