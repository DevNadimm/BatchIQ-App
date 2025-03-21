import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/home/models/batch_info_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BatchInfoController extends GetxController {
  static final instance = Get.find<BatchInfoController>();

  var isLoading = false;
  var assignmentCount = 0;
  var examCount = 0;
  BatchInfoModel batchInfoModel = BatchInfoModel();
  final UserController _userController = UserController();

  /// Method to count assignments and exams for a specific batch
  Future<void> countAssignmentsAndExams() async {
    try {
      isLoading = true;
      update();

      final user = await _userController.fetchUserData();
      final batchId = user?.batchId ?? "";

      if (batchId.isEmpty) {
        throw Exception('Batch ID is not available.');
      }

      final assignmentRef = FirebaseFirestore.instance
          .collection('Batches')
          .doc(batchId)
          .collection('Assignments');

      final examRef = FirebaseFirestore.instance
          .collection('Batches')
          .doc(batchId)
          .collection('ExamSchedules');

      final assignmentSnapshot = await assignmentRef.get();
      assignmentCount = assignmentSnapshot.docs.length;

      final examSnapshot = await examRef.get();
      examCount = examSnapshot.docs.length;

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      assignmentCount = 0;
      examCount = 0;
      update();
    }
  }

  /// Method to fetch batch information
  Future<void> fetchBatchInfo() async {
    try {
      isLoading = true;
      update();

      final user = await _userController.fetchUserData();
      final batchId = user?.batchId ?? "";

      if (batchId.isEmpty) {
        throw Exception('Batch ID is not available.');
      }

      final batchRef = FirebaseFirestore.instance.collection('Batches').doc(batchId);

      final batchSnapshot = await batchRef.get();

      if (batchSnapshot.exists) {
        batchInfoModel = BatchInfoModel.fromFirestore(batchSnapshot.data()!);
      } else {
        throw Exception('Batch information not found.');
      }

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      batchInfoModel = BatchInfoModel();
      update();
    }
  }
}
