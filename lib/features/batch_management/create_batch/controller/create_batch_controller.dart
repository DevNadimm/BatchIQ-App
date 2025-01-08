import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateBatchController extends GetxController {
  static final instance = Get.find<CreateBatchController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> createBatch({
    required String uid,
    required String batchName,
    required String description,
  }) async {
    final firestore = FirebaseFirestore.instance;
    final batchId = generateUniqueCode();

    isLoading = true;
    update();

    try {
      await firestore.collection("Batches").doc(batchId).set({
        "createdBy": uid,
        "createdAt": FieldValue.serverTimestamp(),
        "name": batchName,
        "description": description,
      });

      await firestore.collection("Users").doc(uid).update({
        "batchId": batchId.toString(),
      });

      // Upload batch member
      final user = await firestore.collection("Users").doc(uid).get();
      final userName = await user["name"];
      final userRole = await user["role"];

      Map<String, dynamic> userBody = {
         "name": userName,
         "joinedAt": FieldValue.serverTimestamp(),
         "role": userRole
       };

      await firestore.collection("Batches").doc(batchId).collection("Members").doc(uid).set(userBody);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to submit application!";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }

  String generateUniqueCode() {
    final random = Random();
    const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a fixed-length code (e.g., A7B3D2E1)
    String uniqueCode = '';
    for (int i = 0; i < 4; i++) {
      uniqueCode += letters[random.nextInt(letters.length)];
      uniqueCode += timestamp[random.nextInt(timestamp.length)];
    }
    return uniqueCode;
  }
}
