import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/assignment_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AssignmentController extends GetxController {
  static final AssignmentController instance = Get.find<AssignmentController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  List<AssignmentModel> assignments = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<bool> getAssignments() async {
    _setLoading(true);
    try {
      assignments.clear();

      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Assignments")
          .get();

      assignments = querySnapshot.docs
          .map((doc) => AssignmentModel.fromFirestore(doc.data(), doc.id))
          .toList();

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to load assignments";
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> createAssignment({
    required String title,
    required String description,
    required String link,
    required String deadline,
    required bool sendNotification,
    required bool addToCalendar,
  }) async {
    _setLoading(true);
    try {
      final data = await _userController.fetchUserData();
      final uid = data?.uid ?? "";
      final batchId = data?.batchId ?? "";
      final docId = generateDocId("ASSIGNMENT-");

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Assignments").doc(docId).set({
        "createdBy": uid,
        "deadline": deadline,
        "title": title,
        "description": description,
        "link": link,
      });

      if (addToCalendar) {
        await batchRef.collection("MyCalendar").doc(docId).set({
          "title": title,
          "description": description,
          "createdBy": uid,
          "date": deadline,
          "eventType": "assignment",
        });
      }

      if (sendNotification) {
        await NotificationController.instance.createNotification(
          type: 'assignment',
          title: title,
          body: description,
          documentId: docId,
        );
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to upload assignment!";
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> editAssignment({
    required String title,
    required String description,
    required String link,
    required String deadline,
    required String docId,
  }) async {
    _setLoading(true);
    try {
      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Assignments").doc(docId).update({
        "deadline": deadline,
        "title": title,
        "description": description,
        "link": link,
      });

      final calendarDocRef = batchRef.collection("MyCalendar").doc(docId);
      final calendarDocSnapshot = await calendarDocRef.get();

      if (calendarDocSnapshot.exists) {
        await calendarDocRef.update({
          "title": title,
          "description": description,
          "date": deadline,
        });
      }

      await NotificationController.instance.editNotification(
        title: title,
        body: description,
        batchId: batchId,
        notificationId: docId,
      );

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to edit assignment!";
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> deleteAssignment(String assignmentId) async {
    _setLoading(true);
    try {
      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Assignments").doc(assignmentId).delete();

      final calendarDocRef = batchRef.collection("MyCalendar").doc(assignmentId);
      final calendarDocSnapshot = await calendarDocRef.get();

      if (calendarDocSnapshot.exists) {
        await calendarDocRef.delete();
      }

      await NotificationController.instance.deleteNotification(
        notificationId: assignmentId,
      );

      assignments.removeWhere((assignment) => assignment.id == assignmentId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to delete assignment";
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
