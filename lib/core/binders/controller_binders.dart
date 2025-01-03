import 'package:batchiq_app/features/auth/controller/sign_in_controller.dart';
import 'package:batchiq_app/features/auth/controller/sign_up_controller.dart';
import 'package:batchiq_app/features/create_batch/controller/apply_admin_controller.dart';
import 'package:batchiq_app/features/create_batch/controller/create_batch_controller.dart';
import 'package:get/get.dart';

class ControllerBinders implements Bindings{
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(ApplyAdminController());
    Get.put(CreateBatchController());
  }
}