import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AnnouncementAdminController extends GetxController {
  static final instance = Get.find<AnnouncementAdminController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  List<AnnouncementModel> announcements = [];

  Future<bool> getAnnouncements() async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      announcements.clear();
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final batchId = data?.batchId ?? "";

      final querySnapshot = await firestore.collection("Batches").doc(batchId).collection("Announcements").get();

      for (var doc in querySnapshot.docs) {
        final announcement = AnnouncementModel.fromFirestore(doc.data(), doc.id);
        announcements.add(announcement);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to load announcements";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }

  Future<bool> deleteAnnouncement(String announcementId) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      /// For Announcements
      await firestore.collection("Batches").doc(batchId).collection("Announcements").doc(announcementId).delete();

      /// For My Calendar
      final calendarDocRef = firestore.collection("Batches").doc(batchId).collection("MyCalendar").doc(announcementId);
      final calendarDocSnapshot = await calendarDocRef.get();
      if (calendarDocSnapshot.exists) {
        await calendarDocRef.delete();
      }

      /// For Notification
      final notificationDocRef = firestore.collection("Batches").doc(batchId).collection("Notifications").doc(announcementId);
      final notificationDocSnapshot = await notificationDocRef.get();
      if (notificationDocSnapshot.exists) {
        await notificationDocRef.delete();
      }

      announcements.removeWhere((announcement) => announcement.id == announcementId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to delete announcement";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
