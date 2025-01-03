import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateBatchController extends GetxController {
  static final instance = Get.find<CreateBatchController>();

  String? errorMessage;
  bool isSuccess = false;

  Future<bool> createBatch({
    required String uid,
    required String name,
    required String email,
    required String reason,
  }) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection("AdminApplications").doc(uid).set({
        "userId": uid,
        "fullName": name,
        "email": email,
        "reason": reason,
        "appliedAt": FieldValue.serverTimestamp(),
        "status": "pending",
      });

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to submit application!";
    }
    return isSuccess;
  }
}
