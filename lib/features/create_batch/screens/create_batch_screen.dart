import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/progress_indicator.dart';
import 'package:batchiq_app/core/utils/snackbar_message.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/create_batch/controller/create_batch_controller.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateBatchScreen extends StatefulWidget {
  const CreateBatchScreen({super.key});

  @override
  State<CreateBatchScreen> createState() => _CreateBatchScreenState();
}

class _CreateBatchScreenState extends State<CreateBatchScreen> {
  final TextEditingController batchNameController = TextEditingController();
  final TextEditingController batchDescriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Create a Batch",
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
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
                  "Create your batch to manage and organize group activities effectively. Please provide accurate details to ensure easy identification.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: batchNameController,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Batch Name",
                  hintText: "Enter a unique batch name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a batch name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: batchDescriptionController,
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Batch Description",
                  hintText: "Enter a short description for your batch",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a batch description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: GetBuilder<CreateBatchController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.isLoading,
                      replacement: const ProgressIndicatorWidget(),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_globalKey.currentState?.validate() ?? false) {
                            createBatch();
                          }
                        },
                        child: const Text(
                          "Create Batch",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createBatch() async {
    final userController = UserController();
    final user = await userController.fetchUserData();
    final uid = user?.uid ?? "";

    final createBatchController = CreateBatchController.instance;
    final result = await createBatchController.createBatch(
      uid: uid,
      batchName: batchNameController.text.trim(),
      description: batchDescriptionController.text,
    );

    if (result) {
      SnackBarMessage.successMessage("Batch created successfully!");
      Get.off(const HomeScreen());
    } else {
      SnackBarMessage.errorMessage("Failed to create the batch. Please try again.");
    }
  }

  @override
  void dispose() {
    batchNameController.dispose();
    batchDescriptionController.dispose();
    super.dispose();
  }
}
