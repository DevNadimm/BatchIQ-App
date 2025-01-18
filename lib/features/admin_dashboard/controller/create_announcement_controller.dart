import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/create_notification_controller.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateAnnouncementController extends GetxController {
  static final instance = Get.find<CreateAnnouncementController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> createAnnouncement({
    required String title,
    required String message,
    required String type,
    required bool sendNotification,
    required bool addToCalendar,
    String? date,
  }) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final uid = data?.uid ?? "";
      final batchId = data?.batchId ?? "";
      final docId = generateDocId("ANNOUNCEMENT-${type.toUpperCase()}-");

      /// Add to Announcements collection
      await firestore.collection("Batches").doc(batchId).collection("Announcements").doc(docId).set({
        "createdBy": uid,
        "createdAt": DateTime.now().toString(),
        "title": title,
        "message": message,
        "type": type,
      });

      /// Add to Calendar if enabled
      if (addToCalendar) {
        await firestore.collection("Batches").doc(batchId).collection("MyCalendar").doc(docId).set({
          "title": title,
          "description": message,
          "createdBy": uid,
          "date": date,
          "eventType": type,
        });
      }

      /// Send Notification if enabled
      if (sendNotification) {
        final notificationController = CreateNotificationController.instance;
        await notificationController.createNotification(
          type: 'announcement',
          title: title,
          body: message,
          documentId: docId,
        );
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to upload announcement!";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
