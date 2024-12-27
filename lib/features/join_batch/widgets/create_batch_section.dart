import 'package:flutter/material.dart';

class CreateBatchSection extends StatelessWidget {
  const CreateBatchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: const Text(
          "Create a Batch",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
