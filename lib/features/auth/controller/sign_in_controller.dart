import 'package:batchiq_app/core/services/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static final instance = Get.find<SignInController>();

  bool isLoading = false;
  bool isSuccess = false;
  bool isJoinedBatch = false;
  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signIn({required String email, required String password}) async {
    _setLoading(true);

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      final uid = _auth.currentUser?.uid;

      if (uid == null || uid.isEmpty) {
        throw Exception("User ID is null or empty.");
      }

      final userDoc = await _firestore.collection("Users").doc(uid).get();
      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        isJoinedBatch = data.containsKey("batchId") && data["batchId"] != null;

        // subscribe to topic
        await NotificationService.instance.subscribeToTopic(data["batchId"]);
      } else {
        isJoinedBatch = false;
      }

      _setSuccess(true);
      return true;
    } on FirebaseAuthException catch (e) {
      _handleError(_getErrorMessage(e.code));
      return false;
    } catch (e) {
      _handleError('Something went wrong! Please try again.');
      return false;
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      default:
        return 'Something went wrong! Please try again.';
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _setSuccess(bool value) {
    isLoading = false;
    isSuccess = value;
    errorMessage = null;
    update();
  }

  void _handleError(String message) {
    isLoading = false;
    isSuccess = false;
    errorMessage = message;
    update();
  }
}
