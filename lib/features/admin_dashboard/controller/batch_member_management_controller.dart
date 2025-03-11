import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/count_members_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/batch_member_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BatchMemberManagementController extends GetxController {
  static final BatchMemberManagementController instance = Get.find<BatchMemberManagementController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  bool isLoadingDuringRoleChange = false;
  List<BatchMemberModel> members = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<bool> getBatchMembers() async {
    _setLoading(true);
    try {
      members.clear();

      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Members")
          .get();

      members = querySnapshot.docs.map((doc) => BatchMemberModel.fromFirestore(doc.data(), doc.id)).toList();

      members.sort((a, b) {
        return a.role.compareTo(b.role);
      });

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchBatchMembersError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> changeMemberRole({
    required String role,
    required String docId,
  }) async {
    isLoadingDuringRoleChange = true;
    update();

    try {
      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";
      final currentUserDocId = data?.uid ?? "";

      final currentUserSnapshot = await _firestore.collection("Users").doc(docId).get();
      final currentRole = currentUserSnapshot["role"];

      await MemberCountController.instance.countMembers();
      final adminCount = MemberCountController.instance.adminCount;

      final batchRef = _firestore.collection("Batches").doc(batchId);

      // Prevent the last admin from changing their role to student
      if (currentRole == "admin" && role == "student" && adminCount <= 1) {
        isSuccess = false;
        errorMessage = "At least one admin is required. You cannot change your role to student.";
      } else {
        await batchRef.collection("Members").doc(docId).update({"role": role});
        await _firestore.collection("Users").doc(docId).update({"role": role});

        if (currentUserDocId == docId && currentRole == "admin" && role == "student") {
          Get.offAll(() => const HomeScreen());
        }
        isSuccess = true;
        errorMessage = null;
      }
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.changeMemberRoleError;
    } finally {
      isLoadingDuringRoleChange = false;
      update();
    }

    return isSuccess;
  }
}
