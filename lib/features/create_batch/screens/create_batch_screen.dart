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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                controller: batchNameController,
                decoration: const InputDecoration(
                    labelText: "Batch Name",
                    hintText: "Enter your batch name"
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
                maxLines: 2,
                decoration: const InputDecoration(
                    labelText: "Batch Description",
                    hintText: "Enter your batch description"
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
                    if (_globalKey.currentState?.validate() ?? false) {

                    }
                  },
                  child: const Text(
                    "Create Batch",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
