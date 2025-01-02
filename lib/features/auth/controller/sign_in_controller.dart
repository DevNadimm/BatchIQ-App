import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  static final instance = Get.find<SignInController>();

  bool isLoading = false;
  bool isSuccess = false;
  String? errorMessage;

  Future<bool> signIn({required String email, required String password}) async {
    isLoading = true;
    update();

    final FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
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
      case 'invalid-credential':
        return 'The email or password you entered is invalid. Please check and try again.';
      default:
        return 'Something went wrong! Please try again.';
    }
  }
}
