import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/batch_management/join_batch/screens/join_batch_screen.dart';
import 'package:batchiq_app/features/profile/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class LeaveBatchDialog extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final String batchId;

  LeaveBatchDialog({super.key, required this.batchId});

  Future<void> leaveBatch () async{
    final controller = ProfileController.instance;
    final result = await controller.leaveBatch();

    if(result){
      Get.offAll(const JoinBatchScreen());
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Column(
        children: [
          Icon(
            HugeIcons.strokeRoundedLogout03,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 15),
          Text(
            'Leave Batch?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'Are you sure you want to leave this batch? You will lose access to batch-related content and features.',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white38,
                  minimumSize: const Size(100, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  leaveBatch();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(100, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Leave',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
