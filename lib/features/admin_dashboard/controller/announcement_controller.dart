import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/announcement_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AnnouncementController extends GetxController {
  static final AnnouncementController instance = Get.find<AnnouncementController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  List<AnnouncementModel> announcements = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<Map<String, String?>> _fetchUserData() async {
    final data = await _userController.fetchUserData();
    return {
      "batchId": data?.batchId ?? "",
      "uid": data?.uid ?? "",
    };
  }

  Future<bool> getAnnouncements() async {
    _setLoading(true);
    try {
      announcements.clear();

      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Announcements")
          .get();

      announcements = querySnapshot.docs
          .map((doc) => AnnouncementModel.fromFirestore(doc.data(), doc.id))
          .toList();

      announcements.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchAnnouncementsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> createAnnouncements({
    required String title,
    required String message,
    required String type,
    required bool sendNotification,
    required bool addToCalendar,
    String? date,
  }) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";
      final uid = userData["uid"] ?? "";
      final docId = generateDocId("ANNOUNCEMENT-${type.toUpperCase()}-");

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Announcements").doc(docId).set({
        "createdBy": uid,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
        "title": title,
        "message": message,
        "type": type,
      });

      if (addToCalendar) {
        await batchRef.collection("MyCalendar").doc(docId).set({
          "title": title,
          "description": message,
          "createdBy": uid,
          "date": date,
          "eventType": "announcement",
        });
      }

      if (sendNotification) {
        await NotificationController.instance.createNotification(
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
      errorMessage = ErrorMessages.createAnnouncementsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> editAnnouncements({
    required String title,
    required String message,
    required String docId,
  }) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Announcements").doc(docId).update({
        "title": title,
        "message": message,
        "updatedAt": DateTime.now().toString(),
      });

      final myCalenderSnapshot = await batchRef.collection("MyCalendar").doc(docId).get();
      if (myCalenderSnapshot.exists) {
        await batchRef.collection("MyCalendar").doc(docId).update({
          "title": title,
          "description": message,
        });
      }

      await NotificationController.instance.editNotification(
        title: title,
        body: message,
        batchId: batchId,
        notificationId: docId,
      );

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.editAnnouncementsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> deleteAnnouncements(String announcementId) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("Announcements").doc(announcementId).delete();
      await batchRef.collection("MyCalendar").doc(announcementId).delete();

      await NotificationController.instance.deleteNotification(
        notificationId: announcementId,
      );

      announcements.removeWhere((announcement) => announcement.id == announcementId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteAnnouncementsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
