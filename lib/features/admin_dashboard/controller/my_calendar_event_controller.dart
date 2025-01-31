import 'package:batchiq_app/core/constants/error_messages.dart';
import 'package:batchiq_app/features/admin_dashboard/models/my_calendar_event_model.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyCalendarEventController extends GetxController {
  static MyCalendarEventController get instance => Get.find<MyCalendarEventController>();

  String? errorMessage;
  bool isSuccess = false;
  bool isLoading = false;
  final List<MyCalendarEventModel> events = [];

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

  Future<bool> getEvents() async {
    _setLoading(true);

    try {
      events.clear();
      final userDetails = await _getUserDetails();
      final batchId = userDetails["batchId"] ?? "";

      final querySnapshot = await _firestore
          .collection("Batches")
          .doc(batchId)
          .collection("MyCalendar")
          .get();

      events.addAll(querySnapshot.docs.map((doc) =>
          MyCalendarEventModel.fromFirestore(doc.data(), doc.id)));

      events.sort((a, b) {
        final aDate = _parseDate(a.date);
        final bDate = _parseDate(b.date);
        return aDate.compareTo(bDate);
      });

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.fetchEventsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  Future<bool> deleteEvent(String eventId) async {
    _setLoading(true);
    try {
      final data = await _userController.fetchUserData();
      final batchId = data?.batchId ?? "";

      final batchRef = _firestore.collection("Batches").doc(batchId);
      await batchRef.collection("MyCalendar").doc(eventId).delete();

      events.removeWhere((event) => event.id == eventId);

      isSuccess = true;
      errorMessage = null;
    } catch (e) {
      isSuccess = false;
      errorMessage = ErrorMessages.deleteEventsError;
    } finally {
      _setLoading(false);
    }

    return isSuccess;
  }

  DateTime _parseDate(String dateStr) {
    final formatter = DateFormat('MMM dd, yyyy');
    return formatter.parse(dateStr);
  }
}
