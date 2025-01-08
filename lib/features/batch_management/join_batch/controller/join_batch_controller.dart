import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class JoinBatchController extends GetxController {
  static final instance = Get.find<JoinBatchController>();
  String? _errorMessage;
  bool _isSuccess = false;
  bool _isLoading = false;

  bool get isSuccess => _isSuccess;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// Join a batch by updating the user's `batchId`.
  Future<bool> joinBatch({required String userId, required String batchId}) async {
    _setLoading(true);
    _resetState();

    final firestore = FirebaseFirestore.instance;
    final isBatchExists = await _isBatchExists(batchId);

    if (isBatchExists) {
      try {
        await firestore.collection("Users").doc(userId).update({
          "batchId": batchId,
        });
        _isSuccess = true;
      } catch (e) {
        _isSuccess = false;
        _errorMessage = "Unable to join the batch at the moment. Please try again later.";
      }
    } else {
      _isSuccess = false;
      _errorMessage = "The batch ID you entered does not exist. Please check and try again.";
    }

    _setLoading(false);
    return _isSuccess;
  }

  /// Check if a batch exists in Firestore.
  Future<bool> _isBatchExists(String batchId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final batchDoc = await firestore.collection("Batches").doc(batchId).get();
      return batchDoc.exists;
    } catch (e) {
      _errorMessage = "Error checking batch existence: $e";
      return false;
    }
  }

  /// Set the loading state.
  void _setLoading(bool value) {
    _isLoading = value;
    update();
  }

  /// Reset error message and success status.
  void _resetState() {
    _errorMessage = null;
    _isSuccess = false;
  }
}
