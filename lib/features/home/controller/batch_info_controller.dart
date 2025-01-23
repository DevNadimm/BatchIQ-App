import 'package:batchiq_app/features/home/models/batch_info_model.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BatchInfoController extends GetxController {
  static final instance = Get.find<BatchInfoController>();

  var isLoading = false;
  var assignmentCount = 0;
  BatchInfoModel batchInfoModel = BatchInfoModel();

  /// Method to count assignments for a specific batch
  Future<void> countAssignments(String batchId) async {
    try {
      isLoading = true;
      update();

      if (batchId.isEmpty) {
        throw Exception('Batch ID is not available.');
      }

      final assignmentRef = FirebaseFirestore.instance
          .collection('Batches')
          .doc(batchId)
          .collection('Assignments');

      final assignmentSnapshot = await assignmentRef.get();
      assignmentCount = assignmentSnapshot.docs.length;

      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      assignmentCount = 0;
      update();
    }
  }

  /// Method to fetch batch information
  Future<void> fetchBatchInfo(String batchId) async {
    try {
      isLoading = true;
      update();

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
