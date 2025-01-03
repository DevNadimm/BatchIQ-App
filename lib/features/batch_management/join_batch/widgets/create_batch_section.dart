import 'package:batchiq_app/features/batch_management/create_batch/screens/apply_for_admin_screen.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/create_batch_screen.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/current_status_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBatchSection extends StatelessWidget {
  const CreateBatchSection({super.key, required this.isUserAdmin, required this.uid});

  final bool isUserAdmin;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (isUserAdmin) {
            Get.to(CreateBatchScreen());
          } else {
            final firestore = FirebaseFirestore.instance;
            final result = await firestore.collection("AdminApplications").doc(uid).get();
            if (result.exists) {
              final data = result.data() as Map<String, dynamic>;
              final status = data["status"];
              Get.to(CurrentStatusScreen(status: status));
            } else {
              Get.to(const ApplyForAdminScreen());
            }
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
