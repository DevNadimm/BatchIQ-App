import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/resource_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/resources_screens/create_resources_screen.dart';
import 'package:batchiq_app/shared/widgets/resource_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResourcesAdminScreen extends StatefulWidget {
  const ResourcesAdminScreen({super.key});

  @override
  State<ResourcesAdminScreen> createState() => _ResourcesAdminScreenState();
}

class _ResourcesAdminScreenState extends State<ResourcesAdminScreen> {
  List<String> courseList = ["All"];
  String selectedCourse = "All";

  @override
  void initState() {
    fetchResources();
    super.initState();
  }

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
      ),
      body: GetBuilder<ResourceController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: ProgressIndicatorWidget());
          }

          if (controller.resources.isEmpty) {
            return const EmptyList(title: "No resources found!");
          }

          List filteredResources = selectedCourse == "All"
              ? controller.resources
              : controller.resources
                  .where((resource) => resource.courseCode == selectedCourse)
                  .toList();

          return Column(
            children: [
              _buildCourseSelector(),
              Expanded(
                child: filteredResources.isEmpty
                    ? const EmptyList(title: "No resources found!")
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: filteredResources.length,
                        itemBuilder: (context, index) {
                          return ResourceCard(
                            resource: filteredResources[index],
                            isAdmin: true,
                          );
                        },
                      ),
              ),
              Column(
                children: [
                  Divider(
                    height: 1.5,
                    thickness: 1.5,
                    color: Colors.grey.withValues(alpha: 0.2),
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
          );
        },
      ),
    );
  }

  Widget _buildCourseSelector() {
    return Column(
      children: [
        SizedBox(
          height: 55,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            itemCount: courseList.length,
            itemBuilder: (context, index) {
              final courseCode = courseList[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedCourse = courseCode;
                    });
                  },
                  child: Chip(
                    label: Text(
                      courseCode,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selectedCourse == courseCode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    side: BorderSide.none,
                    backgroundColor: selectedCourse == courseCode
                        ? Theme.of(context).primaryColor
                        : Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          color: Colors.grey.withValues(alpha: 0.2),
          height: 1.5,
        ),
      ],
    );
  }

  Future<void> fetchResources() async {
    final controller = ResourceController.instance;
    final result = await controller.getResources();

    if (result) {
      setState(() {
        courseList = [
          "All",
          ...controller.resources
              .map((resource) => resource.courseCode)
              .toSet(),
        ];
      });
    } else {
      SnackBarMessage.errorMessage(
          controller.errorMessage ?? "Something went wrong!");
    }
  }
}
