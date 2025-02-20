import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/member_controller.dart';
import 'package:batchiq_app/core/utils/launch_url.dart';
import 'package:batchiq_app/features/admin_dashboard/models/resource_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

class ResourceViewScreen extends StatefulWidget {
  const ResourceViewScreen({super.key, required this.resource});

  final ResourceModel resource;

  @override
  State<ResourceViewScreen> createState() => _ResourceViewScreenState();
}

class _ResourceViewScreenState extends State<ResourceViewScreen> {

  @override
  void initState() {
    fetchSenderName();
    super.initState();
  }

  Future<void> fetchSenderName() async {
    final controller = MemberController.instance;
    await controller.getUserDataByUid(widget.resource.createdBy);
  }

  String formatDate(String dateString) {
    final dateTime = DateTime.parse(dateString);
    return DateFormat('MMMM dd, yyyy • hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final resource = widget.resource;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Resource",
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
                resource.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                resource.courseName,
                style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: HelperFunctions.getResourceTypeColor(resource.resourcesType).withOpacity(0.1),
                ),
                child: Text(
                  resource.resourcesType,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: HelperFunctions.getResourceTypeColor(resource.resourcesType)),
                ),
              ),

              resource.description.isNotEmpty
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            resource.description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.grey[800],
                                    ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 24),
              resource.url.isNotEmpty ? Column(
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
                            LaunchURL.launchURL(resource.url);
                          },
                          child: Text(
                            resource.url,
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
                      formatDate(resource.createdAt),
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
                              ? "Loading..."
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
