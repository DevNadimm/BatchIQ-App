import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static final instance = Get.find<SignUpController>();

  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    update();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = userCredential.user!.uid;

      await _firestore.collection('Users').doc(uid).set({
        'name': name,
        'email': email,
        'role': 'student',
        'batchId': null,
        'createdAt': FieldValue.serverTimestamp(),
      });

      isLoading = false;
      isSuccess = true;
      errorMessage = null;
      update();
      return isSuccess;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      isSuccess = false;
      errorMessage = _getErrorMessage(e.code);
      update();
      return isSuccess;
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      errorMessage = 'Something went wrong! Please try again.';
      update();
      return isSuccess;
    }
  }

  String _getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return 'This email is already in use. Please try another.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password is too weak. Please use a stronger password.';
      default:
        return 'Something went wrong! Please try again.';
    }
  }
}
