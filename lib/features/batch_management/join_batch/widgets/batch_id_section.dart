import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/batch_management/join_batch/controller/join_batch_controller.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:get/get.dart';

class BatchIDSection extends StatelessWidget {
  const BatchIDSection({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    final TextEditingController batchId = TextEditingController();
    final controller = JoinBatchController.instance;

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
              controller: batchId,
              decoration: const InputDecoration(
                hintText: "e.g. A7B3D2E1",
                hintStyle:
                    TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
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
              final result = await controller.joinBatch(
                  userId: userId, batchId: batchId.text.trim());
              if (result) {
                batchId.clear();
                SnackBarMessage.successMessage(controller.errorMessage ?? "Successfully joined the batch!");
                // Get.offAll(const HomeScreen());
              } else {
                SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              child: controller.isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Icon(Icons.arrow_forward_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
