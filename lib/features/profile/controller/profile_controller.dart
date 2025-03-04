import 'package:batchiq_app/core/services/notification_service.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/count_members_controller.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static final instance = Get.find<ProfileController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  Future<bool> leaveBatch() async {
    final firestore = FirebaseFirestore.instance;

    final userController = UserController();
    final memberCountController = MemberCountController.instance;

    final data = await userController.fetchUserData();

    final batchId = data?.batchId ?? "";
    final uid = data?.uid ?? "";
    final role = data?.role ?? "admin";

    isLoading = true;
    update();

    try {
      await memberCountController.countMembers();
      bool canLeaveBatch = memberCountController.adminCount > 1 || role != "admin";

      if (canLeaveBatch) {
        try {
          /// Notification collection delete
          final subCollections = await firestore
              .collection("Batches")
              .doc(batchId)
              .collection("Members")
              .doc(uid)
              .collection("Notifications")
              .get();

          for (var subCollection in subCollections.docs) {
            await subCollection.reference.delete();
          }

          /// Batch member delete
          await firestore
              .collection("Batches")
              .doc(batchId)
              .collection("Members")
              .doc(uid)
              .delete();

          /// Users collection update
          await firestore.collection("Users").doc(uid).update({
            "batchId": "",
            "role": "student"
          });

          /// Unsubscribe from topic
          await NotificationService.instance.unsubscribeFromTopic(batchId);

          isSuccess = true;
          errorMessage = null;
        } catch (e) {
          isSuccess = false;
          errorMessage = "Failed to leave the batch!";
        }
      } else {
        errorMessage = "You cannot leave the batch as the last admin. Please assign a new admin before leaving.";
        isSuccess = false;
      }
    } catch (e) {
      isSuccess = false;
      errorMessage = "Failed to leave batch!";
    } finally {
      isLoading = false;
      update();
    }

    return isSuccess;
  }
}
