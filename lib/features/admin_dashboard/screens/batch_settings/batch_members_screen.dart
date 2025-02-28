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
  @override
  void initState() {
    fetchMembers();
    super.initState();
  }

  Future<void> fetchMembers() async {
    final controller = BatchMemberListController.instance;
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
                    // TODO: Change Role Functionality Here...
                    debugPrint("Long Pressed!");
                  },
                );
              },
            ),
          );
        },
      ),
    );
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
          contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
        ),
      ],
    );
  }
}
