import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/models/class_schedule_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClassScheduleController extends GetxController {
  static final ClassScheduleController instance = Get.find<ClassScheduleController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserController _userController = UserController();

  List<ClassScheduleModel> classSchedules = [];

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

  void _sortClassesByTime() {
    classSchedules.sort((a, b) {
      final startTimeA = DateFormat.jm().parse(a.startTime);
      final startTimeB = DateFormat.jm().parse(b.startTime);
      return startTimeA.compareTo(startTimeB);
    });
  }

  /// Fetches all class schedules from Firestore
  Future<bool> getClassSchedules() async {
    _setLoading(true);
    try {
      classSchedules.clear();

      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("ClassSchedules")
          .get();

      classSchedules = querySnapshot.docs
          .map((doc) => ClassScheduleModel.fromFirestore(doc.data(), doc.id))
          .toList();

      _sortClassesByTime();

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchSchedulesError;
    } finally {
      _setLoading(false);
    }

    debugPrint(classSchedules.toString());
    return isSuccess;
  }

  /// Returns a list of class schedules for a specific day
  List<ClassScheduleModel> dayClasses(String day) {
    return classSchedules.where((schedule) => schedule.day == day).toList();
  }

  Future<bool> createClassSchedule({
    required String day,
    required String startTime,
    required String endTime,
    required String courseCode,
    required String courseName,
    required String teacher,
    required String location,
  }) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";
      final docId = generateDocId("CLASS-${day.toUpperCase()}-");

      final batchRef = _firestore.collection("Batches").doc(batchId);

      final classSchedule = ClassScheduleModel(
        id: docId,
        day: day,
        startTime: startTime,
        endTime: endTime,
        courseCode: courseCode,
        courseName: courseName,
        teacher: teacher,
        location: location,
      );

      await batchRef
          .collection("ClassSchedules")
          .doc(docId)
          .set(classSchedule.toFirestore());

      classSchedules.add(classSchedule);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.createSchedulesError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> editClassSchedule({
    required String docId,
    required String day,
    required String startTime,
    required String endTime,
    required String courseCode,
    required String courseName,
    required String teacher,
    required String location,
  }) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("ClassSchedules").doc(docId).update({
        "day": day,
        "startTime": startTime,
        "endTime": endTime,
        "courseCode": courseCode,
        "courseName": courseName,
        "teacher": teacher,
        "location": location,
        "updatedAt": DateTime.now().toString(),
      });

      final index = classSchedules.indexWhere((schedule) => schedule.id == docId);
      if (index != -1) {
        classSchedules[index] = ClassScheduleModel(
          id: docId,
          day: day,
          startTime: startTime,
          endTime: endTime,
          courseCode: courseCode,
          courseName: courseName,
          teacher: teacher,
          location: location,
        );
      }

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.editSchedulesError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> deleteClassSchedule(String scheduleId) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("ClassSchedules").doc(scheduleId).delete();

      classSchedules.removeWhere((schedule) => schedule.id == scheduleId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteSchedulesError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
