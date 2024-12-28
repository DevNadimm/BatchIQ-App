import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CreateBatchScreen extends StatelessWidget {
  final TextEditingController batchNameController = TextEditingController();
  final TextEditingController batchDescriptionController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();

  CreateBatchScreen({super.key});

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
                child: ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState?.validate() ?? false) {}
                  },
                  child: const Text(
                    "Create Batch",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
