import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class EditAssignmentController extends GetxController {
  static final instance = Get.find<EditAssignmentController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> editAssignment({
    required String title,
    required String description,
    required String link,
    required String deadline,
    required String docId,
  }) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final batchId = data?.batchId ?? "";

      /// For Batches
      await firestore.collection("Batches").doc(batchId).collection("Assignments").doc(docId).update({
        "deadline": deadline,
        "title": title,
        "description": description,
        "link": link,
      });

      /// For My Calendar
      final docRef = firestore.collection("Batches").doc(batchId).collection("MyCalendar").doc(docId);
      final docSnapshot = await docRef.get();
      if (docSnapshot.exists) {
        await docRef.update({
          "title": title,
          "description": description,
          "date": deadline,
        });
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to edit assignment!";
    } finally {
      isLoading = false;
      update();
    }
    return isSuccess;
  }
}
