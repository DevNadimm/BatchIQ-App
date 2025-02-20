import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/models/resource_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ResourceController extends GetxController {
  static ResourceController get instance => Get.find<ResourceController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  final List<ResourceModel> resources = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<Map<String, String?>> _getUserDetails() async {
    final data = await _userController.fetchUserData();
    return {
      "batchId": data?.batchId,
      "uid": data?.uid,
    };
  }

  /// ============ Get Resources ============
  Future<bool> getResources() async {
    _setLoading(true);

    try {
      resources.clear();
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Resources")
          .get();

      resources.addAll(querySnapshot.docs.map((doc) =>
          ResourceModel.fromFirestore(doc.data(), doc.id)));

      resources.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchResourcesError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Create Resource ============
  Future<bool> createResource({
    required String title,
    required String description,
    required String courseName,
    required String courseCode,
    required String resourcesType,
    required String url,
  }) async {
    _setLoading(true);

    try {
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";
      final uid = userDetails["uid"] ?? "";
      final docId = generateDocId("RESOURCE-");

      final courseData = {
        "title": title,
        "description": description,
        "courseName": courseName,
        "courseCode": courseCode,
        "resourcesType": resourcesType,
        "url": url,
        "createdAt": DateTime.now().toString(),
        "updatedAt": DateTime.now().toString(),
        "createdBy": uid,
      };

      await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Resources")
          .doc(docId)
          .set(courseData);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.createResourceError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Edit Resource ============
  Future<bool> editResource({
    required String resourceId,
    required String title,
    required String description,
    required String url,
  }) async {
    _setLoading(true);

    final userDetails = await _getUserDetails();
    final batchId = userDetails["batchId"] ?? "";

    try {
      final updateData = {
        "title": title,
        "description": description,
        "url": url,
        "updatedAt": DateTime.now().toString(),
      };

      await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Resources")
          .doc(resourceId)
          .update(updateData);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.editResourceError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  /// ============ Delete Resource ============
  Future<bool> deleteResource({
    required String resourceId,
  }) async {
    _setLoading(true);

    try {
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";

      await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("Resources")
          .doc(resourceId)
          .delete();

      resources.removeWhere((resource) => resource.id == resourceId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteResourceError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
