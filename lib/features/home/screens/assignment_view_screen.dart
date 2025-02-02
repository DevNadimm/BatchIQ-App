import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/member_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/assignment_model.dart';
import 'package:batchiq_app/shared/url_launcher/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class AssignmentViewScreen extends StatefulWidget {
  const AssignmentViewScreen({super.key, required this.assignment});

  final AssignmentModel assignment;

  @override
  State<AssignmentViewScreen> createState() => _AssignmentViewScreenState();
}

class _AssignmentViewScreenState extends State<AssignmentViewScreen> {
  @override
  void initState() {
    fetchSenderName();
    super.initState();
  }

  Future<void> fetchSenderName() async {
    final controller = MemberController.instance;
    await controller.getUserDataByUid(widget.assignment.createdBy);
  }

  @override
  Widget build(BuildContext context) {
    final assignment = widget.assignment;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Assignment",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                assignment.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  assignment.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              assignment.link.isNotEmpty ? Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        HugeIcons.strokeRoundedLink02,
                        size: 20,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            LaunchURL.launchURL(assignment.link);
                          },
                          child: Text(
                            assignment.link,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
              ) : const SizedBox.shrink(),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedCalendar03,
                    size: 20,
                    color: secondaryFontColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Due: ${assignment.deadline}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: secondaryFontColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedUser,
                    size: 20,
                    color: secondaryFontColor,
                  ),
                  const SizedBox(width: 8),
                  GetBuilder<MemberController>(
                    builder: (controller) {
                      return Expanded(
                        child: Text(
                          controller.isLoading
                              ? "Loading...!"
                              : controller.userData?.name ?? "N/A",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: secondaryFontColor),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
