import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/models/exam_schedule_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ExamScheduleController extends GetxController {
  static final ExamScheduleController instance = Get.find<ExamScheduleController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  List<ExamScheduleModel> examSchedules = [];

  void _setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<Map<String, String?>> _fetchUserData() async {
    final data = await _userController.fetchUserData();
    return {
      "batchId": data?.batchId ?? "",
      "uid": data?.uid ?? "",
    };
  }

  /// Fetches all exam schedules from Firestore
  Future<bool> getExamSchedules() async {
    _setLoading(true);
    try {
      examSchedules.clear();

      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("ExamSchedules")
          .get();

      examSchedules = querySnapshot.docs
          .map((doc) => ExamScheduleModel.fromFirestore(doc.data(), doc.id))
          .toList();

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchExamSchedulesError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> createExamSchedule({
    required String scheduledDate,
    required String courseCode,
    required String courseName,
    required String teacher,
    required String examType,
  }) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";
      final uid = userData["uid"] ?? "";
      final docId = generateDocId("${courseCode.replaceAll(' ', '-').toUpperCase()}-${examType.toUpperCase()}-");

      final batchRef = _firestore.collection("Batches").doc(batchId);

      final examSchedule = ExamScheduleModel(
          id: docId,
          course: courseName,
          courseCode: courseCode,
          teacher: teacher,
          scheduledDate: scheduledDate,
          examType: examType,
          createdBy: uid,
          createdAt: DateTime.now().toString()
      );

      await batchRef
          .collection("ExamSchedules")
          .doc(docId)
          .set(examSchedule.toFirestore());

      examSchedules.add(examSchedule);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.createExamScheduleError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
  //
  // Future<bool> editClassSchedule({
  //   required String docId,
  //   required String day,
  //   required String startTime,
  //   required String endTime,
  //   required String courseCode,
  //   required String courseName,
  //   required String teacher,
  //   required String location,
  // }) async {
  //   _setLoading(true);
  //   try {
  //     final userData = await _fetchUserData();
  //     final batchId = userData["batchId"] ?? "";
  //
  //     final batchRef = _firestore.collection("Batches").doc(batchId);
  //
  //     await batchRef.collection("ClassSchedules").doc(docId).update({
  //       "day": day,
  //       "startTime": startTime,
  //       "endTime": endTime,
  //       "courseCode": courseCode,
  //       "courseName": courseName,
  //       "teacher": teacher,
  //       "location": location,
  //       "updatedAt": DateTime.now().toString(),
  //     });
  //
  //     final index = classSchedules.indexWhere((schedule) =>
  //     schedule.id == docId);
  //     if (index != -1) {
  //       classSchedules[index] = ClassScheduleModel(
  //         id: docId,
  //         day: day,
  //         startTime: startTime,
  //         endTime: endTime,
  //         courseCode: courseCode,
  //         courseName: courseName,
  //         teacher: teacher,
  //         location: location,
  //       );
  //     }
  //
  //     isSuccess = true;
  //     errorMessage = null;
  //   } catch (e) {
  //     isSuccess = false;
  //     errorMessage = ErrorMessages.editSchedulesError;
  //   } finally {
  //     _setLoading(false);
  //   }
  //
  //   return isSuccess;
  // }

  // Future<bool> deleteClassSchedule(String scheduleId) async {
  //   _setLoading(true);
  //   try {
  //     final userData = await _fetchUserData();
  //     final batchId = userData["batchId"] ?? "";
  //
  //     final batchRef = _firestore.collection("Batches").doc(batchId);
  //
  //     await batchRef.collection("ClassSchedules").doc(scheduleId).delete();
  //
  //     classSchedules.removeWhere((schedule) => schedule.id == scheduleId);
  //
  //     isSuccess = true;
  //     errorMessage = null;
  //   } catch (e) {
  //     isSuccess = false;
  //     errorMessage = ErrorMessages.deleteSchedulesError;
  //   } finally {
  //     _setLoading(false);
  //   }
  //
  //   return isSuccess;
  // }
}
