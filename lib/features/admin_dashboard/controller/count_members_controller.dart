import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';

class MemberCountController extends GetxController {
  static final instance = Get.find<MemberCountController>();

  var isLoading = false;
  var adminCount = 0;
  var studentCount = 0;

  Future<void> countMembers() async {
    try {
      isLoading = true;
      update();

      final controller = UserController();
      final data = await controller.fetchUserData();
      final batchId = data?.batchId ?? '';

      if (batchId.isEmpty) {
        throw Exception('Batch ID is not available.');
      }

      final memberRef = FirebaseFirestore.instance
          .collection('Batches')
          .doc(batchId)
          .collection('Members');

      final adminQuerySnapshot = await memberRef.where('role', isEqualTo: 'admin').get();
      adminCount = adminQuerySnapshot.size;

      final studentQuerySnapshot = await memberRef.where('role', isEqualTo: 'student').get();
      studentCount = studentQuerySnapshot.size;

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      adminCount = 0;
      studentCount = 0;
      update();
    }
  }
}
