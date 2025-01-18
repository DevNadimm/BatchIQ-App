import 'package:batchiq_app/features/admin_dashboard/models/notification_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationAdminController extends GetxController {
  static final instance = Get.find<NotificationAdminController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  List<NotificationModel> notifications = [];

  Future<bool> getNotifications() async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      notifications.clear();
      final UserController userController = UserController();
      final data = await userController.fetchUserData();

      final batchId = data?.batchId ?? "";

      final querySnapshot = await firestore.collection("Batches").doc(batchId).collection("Notifications").get();

      for (var doc in querySnapshot.docs) {
        final notification = NotificationModel.fromFirestore(doc.data(), doc.id);
        notifications.add(notification);
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to load notifications";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }

  Future<bool> deleteNotifications(String notificationId) async {
    final firestore = FirebaseFirestore.instance;

    isLoading = true;
    update();

    try {
      final UserController userController = UserController();
      final data = await userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      /// For Notification
      await firestore.collection("Batches").doc(batchId).collection("Notifications").doc(notificationId).delete();

      notifications.removeWhere((notification) => notification.id == notificationId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to delete notification";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
