import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/helper/helper_functions.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/resource_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/models/resource_model.dart';
import 'package:batchiq_app/core/utils/launch_url.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/resources_screens/edit_resource_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/resources_screens/resource_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class ResourceCard extends StatelessWidget {
  const ResourceCard(
      {super.key, required this.resource, required this.isAdmin});

  final ResourceModel resource;
  final bool isAdmin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ResourceViewScreen(resource: resource));
      },
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(width: 1.5, color: primaryColor.withOpacity(0.1)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      resource.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (isAdmin)
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      position: PopupMenuPosition.under,
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                          onTap: () {
                            Get.to(
                              EditResourcesScreen(
                                resourceId: resource.id,
                                title: resource.title,
                                description: resource.description,
                                url: resource.url,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedNoteEdit,
                                color: secondaryFontColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Edit",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: secondaryFontColor),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () async {
                            await deleteResource();
                          },
                          child: Row(
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedDelete01,
                                color: secondaryFontColor,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Delete",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: secondaryFontColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                      child: const Icon(
                        HugeIcons.strokeRoundedMoreVertical,
                        color: Colors.black87,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: HelperFunctions.getResourceTypeColor(resource.resourcesType).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  resource.resourcesType,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: HelperFunctions.getResourceTypeColor(resource.resourcesType),
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    HugeIcons.strokeRoundedBook02,
                    size: 16,
                    color: secondaryFontColor,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: resource.courseCode,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w600, color: secondaryFontColor
                            ),
                          ),
                          TextSpan(
                            text: " - ",
                            style: TextStyle(color: secondaryFontColor),
                          ),
                          TextSpan(
                            text: resource.courseName,
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: secondaryFontColor,
                            ),
                          ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        HugeIcons.strokeRoundedCalendar03,
                        size: 16,
                        color: secondaryFontColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        HelperFunctions.parseTimestamp(resource.createdAt),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: secondaryFontColor),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      LaunchURL.launchURL(resource.url);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          HugeIcons.strokeRoundedLink02,
                          color: Colors.blue,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "Open Resource",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteResource() async {
    final controller = ResourceController.instance;
    final isDelete = await controller.deleteResource(resourceId: resource.id);
    if (isDelete) {
      SnackBarMessage.successMessage("Your resource has been deleted successfully!");
    } else {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    }
  }
}
