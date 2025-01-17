import 'package:batchiq_app/features/admin_dashboard/controller/assignment_admin_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/count_members_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/create_assignment_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/create_notification_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/edit_assignment_controller.dart';
import 'package:batchiq_app/features/auth/controller/sign_in_controller.dart';
import 'package:batchiq_app/features/auth/controller/sign_up_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/apply_admin_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/create_batch_controller.dart';
import 'package:batchiq_app/features/batch_management/join_batch/controller/join_batch_controller.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(ApplyAdminController());
    Get.put(CreateBatchController());
    Get.put(JoinBatchController());
    Get.put(CreateAssignmentController());
    Get.put(AssignmentAdminController());
    Get.put(EditAssignmentController());
    Get.put(MemberCountController());
    Get.put(CreateNotificationController());
  }
}