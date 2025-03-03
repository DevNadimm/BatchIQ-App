import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/batch_member_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchMembersScreen extends StatefulWidget {
  const BatchMembersScreen({super.key});

  @override
  State<BatchMembersScreen> createState() => _BatchMembersScreenState();
}

class _BatchMembersScreenState extends State<BatchMembersScreen> {
  List<String> roles = ["admin", "student"];
  String? selectedRole;

  @override
  void initState() {
    fetchMembers();
    super.initState();
  }

  Future<void> fetchMembers() async {
    final controller = BatchMemberListController.instance;
    final result = await controller.getBatchMembers();

    if (!result) {
      SnackBarMessage.errorMessage(
          controller.errorMessage ?? "Something went wrong!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Batch Members",
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
      body: GetBuilder<BatchMemberListController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: ListView.builder(
              itemCount: controller.members.length,
              itemBuilder: (context, index) {
                final member = controller.members[index];
                return _buildListItem(
                  context,
                  name: member.name,
                  role: member.role,
                  onTap: () {
                    // TODO: Separate bottom modal sheet as a widget
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Change Role",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        onPressed: () => Get.back(),
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: roles.length,
                                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                                    itemBuilder: (context, index) {
                                      final role = roles[index];
                                      selectedRole = selectedRole ?? member.role;
                                      final isSelected = selectedRole == role;

                                      return InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          setModalState(() {
                                            selectedRole = role;
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 16),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: isSelected
                                                ? Colors.blue.withOpacity(0.1)
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: isSelected ? primaryColor : Colors.grey.shade300,
                                              width: isSelected ? 1.5 : 1,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  role[0].toUpperCase() + role.substring(1),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: isSelected ? primaryColor : Colors.black87,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              if (isSelected)
                                                Icon(Icons.check_circle, color: primaryColor),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        changeRole(role: selectedRole!, docId: member.id);
                                      },
                                      child: GetBuilder<BatchMemberListController>(
                                        builder: (controller) {
                                          return Visibility(
                                            visible: !controller.isLoadingWhenChangeRole,
                                            replacement: const ProgressIndicatorWidget(
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                            child: const Text(
                                              "Save",
                                              style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.w600),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );

                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> changeRole({required String role, required final String docId}) async {
    final controller = BatchMemberListController.instance;
    final result = await controller.changeMemberRole(role: role, docId: docId);

    if (!result) {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
      Get.back();
    } else {
      Get.back();
      await controller.getBatchMembers();
    }
  }

  Widget _buildListItem(
    BuildContext context, {
    required String name,
    required String role,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          splashColor: primaryColor.withOpacity(0.1),
          leading: CircleAvatar(
            backgroundColor: role == "admin"
                ? Colors.red.shade100
                : Theme.of(context).primaryColor.withOpacity(0.1),
            child: Text(
              name[0],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          title: Text(
            name,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            role = role[0].toUpperCase() + role.substring(1),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: secondaryFontColor, fontWeight: FontWeight.w500),
          ),
          onLongPress: onTap,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
        ),
      ],
    );
  }
}
