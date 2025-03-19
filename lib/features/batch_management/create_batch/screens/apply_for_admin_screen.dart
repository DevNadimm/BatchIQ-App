import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/apply_admin_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/current_status_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplyForAdminScreen extends StatefulWidget {
  const ApplyForAdminScreen({super.key});

  @override
  State<ApplyForAdminScreen> createState() => _ApplyForAdminScreenState();
}

class _ApplyForAdminScreenState extends State<ApplyForAdminScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late String uid;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    isLoading = true;
    setState(() {});
    final controller = UserController();
    final user = await controller.fetchUserData();
    nameController.text = user?.name ?? "";
    emailController.text = user?.email ?? "";
    uid = user?.uid ?? "";
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Apply for Admin",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1.5,
          ),
        ),
      ),
      body: Visibility(
        visible: !isLoading,
        replacement: const ProgressIndicatorWidget(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "To create a batch, you need to be an admin. Apply below to become an admin and manage batches.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: nameController,
                    labelText: "Full Name",
                    hintText: "Enter your full name",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: emailController,
                    labelText: "Email Address",
                    hintText: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zAZ0-9.-]+$")
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: reasonController,
                    labelText: "Reason for Applying",
                    hintText: "Why do you want to be an admin?",
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please provide a reason';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your application will be reviewed, and we will contact you at the email address provided.",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  _buildSubmitButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator,
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: GetBuilder<ApplyAdminController>(
        builder: (controller) {
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                applyAdmin();
              }
            },
            child: Visibility(
              visible: !controller.isLoading,
              replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
              child: const Text(
                "Apply for Admin",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }
      ),
    );
  }

  Future<void> applyAdmin() async {
    final controller = ApplyAdminController.instance;
    final result = await controller.applyAdmin(
      uid: uid,
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      reason: reasonController.text,
    );

    if (result) {
      SnackBarMessage.successMessage("Application submitted successfully!");
      nameController.clear();
      emailController.clear();
      reasonController.clear();
      Get.off(const CurrentStatusScreen(status: "pending"));
    } else {
      SnackBarMessage.errorMessage("Failed to submit the application. Please try again.");
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
