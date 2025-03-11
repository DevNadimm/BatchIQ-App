import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/batch_member_management_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeRoleBottomSheet extends StatefulWidget {
  final String docId;
  final String initialRole;

  const ChangeRoleBottomSheet({
    super.key,
    required this.docId,
    required this.initialRole,
  });

  @override
  State<ChangeRoleBottomSheet> createState() => _ChangeRoleBottomSheetState();
}

class _ChangeRoleBottomSheetState extends State<ChangeRoleBottomSheet> {
  late String selectedRole;
  final List<String> roles = ["admin", "student"];

  @override
  void initState() {
    super.initState();
    selectedRole = widget.initialRole;
  }

  Future<void> _changeRole() async {
    final controller = BatchMemberManagementController.instance;
    final result = await controller.changeMemberRole(
      role: selectedRole,
      docId: widget.docId,
    );

    if (!result) {
      Get.back();
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
    } else {
      Get.back();
      await controller.getBatchMembers();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              final isSelected = selectedRole == role;

              return InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    selectedRole = role;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
              onPressed: () async {
                await _changeRole();
              },
              child: GetBuilder<BatchMemberManagementController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.isLoadingDuringRoleChange,
                    replacement: const ProgressIndicatorWidget(
                      size: 20,
                      color: Colors.white,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}