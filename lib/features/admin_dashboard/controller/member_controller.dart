import 'package:batchiq_app/features/auth/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MemberController extends GetxController {
  static final MemberController instance = Get.find<MemberController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? userData;

  Future<bool> getUserDataByUid(String uid) async {
    _setLoading(true);
    try {
      final userDoc = await _firestore.collection("Users").doc(uid).get();

      if (userDoc.exists) {
        userData = UserModel.fromMap(userDoc.id, userDoc.data()!);
        isSuccess = true;
        errorMessage = null;
      } else {
        _setError("No information found for this user. Please check the details and try again.");
      }
    } on FirebaseException catch (e) {
      if (e.code == 'not-found') {
        _setError("We couldn't find the requested data. Please try again later.");
      } else {
        _setError("Something went wrong while fetching user details. Please try again.");
      }
    } catch (e) {
      _setError("An unexpected error occurred. Please check your internet connection and try again.");
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  void _setError(String message) {
    isSuccess = false;
    errorMessage = message;
    update();
  }
}
