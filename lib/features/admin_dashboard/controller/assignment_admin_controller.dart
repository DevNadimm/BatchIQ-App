import 'package:batchiq_app/features/admin_dashboard/models/assignment_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AssignmentAdminController extends GetxController {
  static final instance = Get.find<AssignmentAdminController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  List<AssignmentModel> assignments = [];

  Future<bool> getAssignments() async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      assignments.clear();
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final batchId = data?.batchId ?? "";

      final querySnapshot = await firestore.collection("Batches").doc(batchId).collection("Assignments").get();

      for (var doc in querySnapshot.docs) {
        final assignment = AssignmentModel.fromFirestore(doc.data(), doc.id);
        assignments.add(assignment);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to load assignments";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }

  Future<bool> deleteAssignment(String assignmentId) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      /// For Batches
      await firestore.collection("Batches").doc(batchId).collection("Assignments").doc(assignmentId).delete();

      /// For My Calendar
      final calendarDocRef = firestore.collection("Batches").doc(batchId).collection("MyCalendar").doc(assignmentId);
      final calendarDocSnapshot = await calendarDocRef.get();
      if (calendarDocSnapshot.exists) {
        await calendarDocRef.delete();
      }

      /// For Notification
      final notificationDocRef = firestore.collection("Batches").doc(batchId).collection("Notifications").doc(assignmentId);
      final notificationDocSnapshot = await notificationDocRef.get();
      if (notificationDocSnapshot.exists) {
        await notificationDocRef.delete();
      }

      assignments.removeWhere((assignment) => assignment.id == assignmentId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to delete assignment";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
