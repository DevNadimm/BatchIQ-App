import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/resources_screens/create_resources_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResourcesAdminScreen extends StatefulWidget {
  const ResourcesAdminScreen({super.key});

  @override
  State<ResourcesAdminScreen> createState() => _ResourcesAdminScreenState();
}

class _ResourcesAdminScreenState extends State<ResourcesAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Resources",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
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
      body: Column(
        children: [
          const Expanded(
            child: Center(
              child: Text("Resources"),
            ),
          ),
          Column(
            children: [
              Divider(
                height: 1.5,
                thickness: 1.5,
                color: Colors.grey.withOpacity(0.2),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Get.to(() => const CreateResourcesScreen());
                  },
                  child: const Text(
                    "Create Resource",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
