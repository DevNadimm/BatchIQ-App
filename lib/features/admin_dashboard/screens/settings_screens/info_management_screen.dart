import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/batch_management/create_batch/controller/create_batch_controller.dart';
import 'package:batchiq_app/features/home/controller/batch_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoManagementScreen extends StatefulWidget {
  const InfoManagementScreen({super.key});

  @override
  State<InfoManagementScreen> createState() => _InfoManagementScreenState();
}

class _InfoManagementScreenState extends State<InfoManagementScreen> {
  final TextEditingController batchNameController = TextEditingController();
  final TextEditingController batchDescriptionController = TextEditingController();
  final controller = BatchInfoController.instance;
  final GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchBatchInfo();
    });
  }

  Future<void> fetchBatchInfo() async {
    await controller.fetchBatchInfo();

    batchNameController.text = controller.batchInfoModel.name;
    batchDescriptionController.text = controller.batchInfoModel.description;

    controller.update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        // title: Text(
        //   "Create a Batch",
        //   style: Theme.of(context).textTheme.headlineSmall,
        // ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(backArrow),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1.5,
          ),
        ),
      ),
      body: GetBuilder<BatchInfoController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          return ElevatedButton(
                            onPressed: () {
                              if (_globalKey.currentState?.validate() ?? false) {
                                editBatch();
                              }
                            },
                            child: Visibility(
                              visible: !controller.isLoading,
                              replacement: const ProgressIndicatorWidget(size: 25, color: Colors.white),
                              child: const Text(
                                "Save Changes",
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
      ),
    );
  }

  Future<void> editBatch() async {
    final createBatchController = CreateBatchController.instance;
    final result = await createBatchController.updateBatch(
      batchName: batchNameController.text.trim(),
      description: batchDescriptionController.text,
    );

    if(!result) {
      SnackBarMessage.errorMessage(createBatchController.errorMessage ?? "Something went wrong!");
    } else {
      SnackBarMessage.successMessage("Batch information updated successfully!");
    }
  }

  @override
  void dispose() {
    batchNameController.dispose();
    batchDescriptionController.dispose();
    super.dispose();
  }
}
