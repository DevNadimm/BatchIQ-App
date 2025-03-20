import 'package:get/get.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/exam_schedule_controller.dart';
import 'package:batchiq_app/features/auth/controller/google_auth_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/batch_member_management_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/member_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/my_calendar_event_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/resource_controller.dart';
import 'package:batchiq_app/features/home/controller/batch_info_controller.dart';
import 'package:batchiq_app/features/profile/controller/profile_controller.dart';
import 'package:batchiq_app/features/auth/controller/sign_in_controller.dart';
import 'package:batchiq_app/features/auth/controller/sign_up_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/apply_admin_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/create_batch_controller.dart';
import 'package:batchiq_app/features/batch_management/join_batch/controller/join_batch_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/announcement_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/assignment_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/count_members_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/notification_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    // Auth Feature
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(GoogleAuthController());

    // Batch Management Feature
    Get.put(ApplyAdminController());
    Get.put(CreateBatchController());
    Get.put(JoinBatchController());
    Get.put(ProfileController());

    // Admin Dashboard Feature
    Get.put(MemberCountController());
    Get.put(AssignmentController());
    Get.put(NotificationController());
    Get.put(AnnouncementController());
    Get.put(ClassScheduleController());
    Get.put(ExamScheduleController());
    Get.put(MyCalendarEventController());
    Get.put(CourseController());
    Get.put(ResourceController());
    Get.put(BatchMemberManagementController());

    // Home Feature
    Get.put(BatchInfoController());

    // Other
    Get.put(MemberController());
  }
}
