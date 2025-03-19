import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/core/utils/id_generator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/exam_schedule_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      
      examSchedules.sort((a, b) => b.scheduledDate.compareTo(a.scheduledDate));

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
    required bool sendNotification,
    required bool addToCalendar,
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
          createdAt: DateTime.now().toString(),
      );

      await batchRef
          .collection("ExamSchedules")
          .doc(docId)
          .set(examSchedule.toFirestore());

      if (addToCalendar) {
        String calendarTitle = "Exam for $courseName ($courseCode)";
        String calendarDescription = "Exam scheduled for $courseName ($courseCode) with $teacher. Exam Type: $examType. Scheduled Date: $scheduledDate.";
        await batchRef.collection("MyCalendar").doc(docId).set({
          "title": calendarTitle,
          "description": calendarDescription,
          "createdBy": uid,
          "date": formatDateString(scheduledDate),
          "eventType": "exam",
        });
      }

      if (sendNotification) {
        String notificationTitle = "Your $examType Exam for '$courseName' ($courseCode) is Coming Up!";
        String notificationBody =
            "Attention all students: The $examType exam for '$courseName' ($courseCode) is approaching!\n\n"
            "Instructor: $teacher\n"
            "Scheduled Date: ${formatDateString(scheduledDate)}\n\n"
            "Be prepared and mark your calendars!";

        await NotificationController.instance.createNotification(
          type: 'exam',
          title: notificationTitle,
          body: notificationBody,
          documentId: docId,
        );
      }

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

  String formatDateString(String dateString) {
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('MMM d, yyyy').format(date);
    return formattedDate;
  }

  Future<bool> deleteExamSchedule(String id) async {
    _setLoading(true);
    try {
      final userData = await _fetchUserData();
      final batchId = userData["batchId"] ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);

      await batchRef.collection("ExamSchedules").doc(id).delete();

      examSchedules.removeWhere((schedule) => schedule.id == id);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteExamScheduleError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }
}
