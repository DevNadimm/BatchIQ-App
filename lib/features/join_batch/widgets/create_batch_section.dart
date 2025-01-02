import 'package:batchiq_app/features/create_batch/screens/apply_for_admin_screen.dart';
import 'package:batchiq_app/features/create_batch/screens/create_batch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBatchSection extends StatelessWidget {
  const CreateBatchSection({super.key, required this.isUserAdmin});

  final bool isUserAdmin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (isUserAdmin) {
            Get.to(CreateBatchScreen());
          } else {
            Get.to(ApplyForAdminScreen());
          }
        },
        child: const Text(
          "Create a Batch",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
