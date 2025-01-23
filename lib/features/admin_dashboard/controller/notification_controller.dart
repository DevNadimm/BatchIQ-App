import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find<NotificationController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  final List<NotificationModel> notifications = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<Map<String, String?>> _getUserDetails() async {
    final data = await _userController.fetchUserData();
    return {
      "batchId": data?.batchId,
      "uid": data?.uid,
    };
  }

  Future<List<DocumentSnapshot>> _getBatchMembers(String batchId) async {
    final membersSnapshot = await _firestore
        .collection("Batches")
        .doc(batchId)
        .collection("Members")
        .get();
    return membersSnapshot.docs;
  }

  /// ============ Get ============
  Future<bool> getNotifications() async {
    _setLoading(true);

    try {
      notifications.clear();
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";
      final memberId = userDetails["uid"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Members")
          .doc(memberId)
          .collection("Notifications")
          .get();

      notifications.addAll(querySnapshot.docs.map((doc) =>
          NotificationModel.fromFirestore(doc.data(), doc.id)));

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchNotificationsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Create ============
  Future<bool> createNotification({
    required String type,
    required String title,
    required String body,
    String? documentId,
  }) async {
    _setLoading(true);

    try {
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";
      final uid = userDetails["uid"] ?? "";

      final members = await _getBatchMembers(batchId);
      if (members.isEmpty) throw Exception("No members found in the batch!");

      final docId = documentId?.isNotEmpty == true
          ? documentId!
          : generateDocId(type.toUpperCase());

      final notificationData = {
        "title": title,
        "body": body,
        "type": type,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
        "createdBy": uid,
        "read": false,
      };

      for (var member in members) {
        await _firestore
            .collection("Batches")
            .doc(batchId)
            .collection("Members")
            .doc(member.id)
            .collection("Notifications")
            .doc(docId)
            .set(notificationData);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.createNotificationsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Edit ============
  Future<bool> editNotification({
    required String batchId,
    required String notificationId,
    required String title,
    required String body,
  }) async {
    _setLoading(true);

    try {
      final members = await _getBatchMembers(batchId);
      if (members.isEmpty) throw Exception("No members found in the batch!");

      final updateData = {
        "title": title,
        "body": body,
        "updatedAt": DateTime.now().toString(),
      };

      for (var member in members) {
        await _firestore
            .collection("Batches")
            .doc(batchId)
            .collection("Members")
            .doc(member.id)
            .collection("Notifications")
            .doc(notificationId)
            .update(updateData);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.editNotificationsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Delete ============
  Future<bool> deleteNotification({
    required String notificationId,
  }) async {
    _setLoading(true);

    try {
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";

      final members = await _getBatchMembers(batchId);
      if (members.isEmpty) throw Exception("No members found in the batch!");

      for (var member in members) {
        await _firestore
            .collection("Batches")
            .doc(batchId)
            .collection("Members")
            .doc(member.id)
            .collection("Notifications")
            .doc(notificationId)
            .delete();
      }

      notifications.removeWhere((notification) => notification.id == notificationId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteNotificationsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Mark Notification ============
  Future<bool> markNotificationAsRead({
    required String batchId,
    required String notificationId,
  }) async {
    _setLoading(true);

    try {
      final members = await _getBatchMembers(batchId);
      if (members.isEmpty) throw Exception("No members found in the batch!");

      final updateData = {
        "updatedAt": DateTime.now().toString(),
        "read": true,
      };

      for (var member in members) {
        await _firestore
            .collection("Batches")
            .doc(batchId)
            .collection("Members")
            .doc(member.id)
            .collection("Notifications")
            .doc(notificationId)
            .update(updateData);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to mark notification as read.";
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
