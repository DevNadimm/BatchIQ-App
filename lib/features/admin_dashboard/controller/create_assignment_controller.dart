import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateAssignmentController extends GetxController {
  static final instance = Get.find<CreateAssignmentController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> createAssignment({
    required String title,
    required String description,
    required String link,
    required String deadline,
  }) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final uid = data?.uid ?? "";
      final batchId = data?.batchId ?? "";
      final docId = generateDocId("ASSIGNMENT");

      await firestore.collection("Batches").doc(batchId).collection("Assignments").doc(docId).set({
        "createdBy": uid,
        "deadline": deadline,
        "title": title,
        "description": description,
        "link": link,
      });

      await firestore.collection("Batches").doc(batchId).collection("MyCalendar").doc(docId).set({
        "title": title,
        "description": description,
        "createdBy": uid,
        "date": deadline,
        "eventType": "assignment",
      });

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to upload assignment!";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
