import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/batch_member_management_controller.dart';
import 'package:batchiq_app/features/admin_dashboard/widgets/change_role_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BatchMembersScreen extends StatefulWidget {
  const BatchMembersScreen({super.key});

  @override
  State<BatchMembersScreen> createState() => _BatchMembersScreenState();
}

class _BatchMembersScreenState extends State<BatchMembersScreen> {
  @override
  void initState() {
    fetchMembers();
    super.initState();
  }

  Future<void> fetchMembers() async {
    final controller = BatchMemberManagementController.instance;
    final result = await controller.getBatchMembers();

    if (!result) {
      SnackBarMessage.errorMessage(controller.errorMessage ?? "Something went wrong!");
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
            color: Colors.grey.withValues(alpha: 0.2),
            height: 1.5,
          ),
        ),
      ),
      body: GetBuilder<BatchMemberManagementController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: const ProgressIndicatorWidget(),
            child: ListView.builder(
              itemCount: controller.members.length,
              itemBuilder: (context, index) {
                final member = controller.members[index];
                return _buildListItem(
                  context: context,
                  name: member.name,
                  role: member.role,
                  onLongPress: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) => ChangeRoleBottomSheet(
                        docId: member.id,
                        initialRole: member.role,
                      ),
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

  Widget _buildListItem({
    required BuildContext context,
    required String name,
    required String role,
    required VoidCallback onLongPress,
  }) {
    return Column(
      children: [
        ListTile(
          splashColor: primaryColor.withValues(alpha: 0.1),
          leading: CircleAvatar(
            backgroundColor: role == "admin"
                ? Colors.red.shade100
                : Theme.of(context).primaryColor.withValues(alpha: 0.1),
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
          onLongPress: onLongPress,
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
        ),
      ],
    );
  }
}
