import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateNotificationController extends GetxController {
  static final instance = Get.find<CreateNotificationController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> createNotification({
    required String type,
    required String title,
    required String body,
    String? documentId,
  }) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final uid = data?.uid ?? "";
      final batchId = data?.batchId ?? "";
      final documentType = type.toUpperCase();

      final String docId = documentId?.isNotEmpty == true
          ? documentId!
          : generateDocId(documentType);

      await firestore.collection("Batches").doc(batchId).collection("Notifications").doc(docId).set({
        "title": title,
        "body": body,
        "type": type,
        "createdAt": FieldValue.serverTimestamp(),
        "createdBy": uid,
      });

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to upload notification!";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
