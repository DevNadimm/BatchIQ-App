import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/empty_list.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/course_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/course_screens/create_course_screen.dart';
import 'package:batchiq_app/shared/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseAdminScreen extends StatefulWidget {
  const CourseAdminScreen({super.key});

  @override
  State<CourseAdminScreen> createState() => _CourseAdminScreenState();
}

class _CourseAdminScreenState extends State<CourseAdminScreen> {
  @override
  void initState() {
    fetchCourses();
    super.initState();
  }

  Future<void> fetchCourses() async {
    final controller = CourseController.instance;
    await controller.getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Courses",
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
          Expanded(
            child: GetBuilder<CourseController>(
              builder: (controller) {
                return Visibility(
                  visible: !controller.isLoading,
                  replacement: const ProgressIndicatorWidget(),
                  child: controller.courses.isEmpty
                      ? const EmptyList(
                          title: "Empty Assignment!",
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.courses.length,
                                itemBuilder: (context, index) {
                                  final course = controller.courses[index];
                                  return CourseCard(course: course, isAdmin: true);
                                },
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                );
              },
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
                    Get.to(() => const CreateCourseScreen());
                  },
                  child: const Text(
                    "Create Course",
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
