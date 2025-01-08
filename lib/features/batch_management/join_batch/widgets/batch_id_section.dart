import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/batch_management/join_batch/controller/join_batch_controller.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';

class BatchIDSection extends StatelessWidget {
  const BatchIDSection({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController batchIdController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: shadeColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: batchIdController,
              decoration: const InputDecoration(
                hintText: "e.g. A7B3D2E1",
                hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await joinBatch(batchIdController.text);
            },
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> joinBatch(String batchId) async {
    final controller = JoinBatchController.instance;

    if (batchId.isEmpty) {
      SnackBarMessage.errorMessage("Please enter your Batch ID");
    } else {
      final result = await controller.joinBatch(
        userId: userId,
        batchId: batchId,
      );
      if (result) {
        SnackBarMessage.successMessage("Successfully joined the batch!");
        Get.offAll(const HomeScreen());
      } else {
        SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
      }
    }
  }
}
