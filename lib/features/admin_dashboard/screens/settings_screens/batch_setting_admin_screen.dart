import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/batch_settings/batch_members_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/settings_screens/info_management_screen.dart';
import 'package:batchiq_app/shared/feature_not_available_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class BatchSettingAdminScreen extends StatefulWidget {
  const BatchSettingAdminScreen({super.key});

  @override
  State<BatchSettingAdminScreen> createState() => _BatchSettingAdminScreenState();
}

class _BatchSettingAdminScreenState extends State<BatchSettingAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Batch Settings",
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
      body: ListView(
        children: [
          _buildListItem(
            context,
            icon: HugeIcons.strokeRoundedSetting07,
            title: "Info Management",
            description: "Edit batch name and description",
            onTap: () {
              Get.to(() => const InfoManagementScreen());
            },
          ),
          _buildListItem(
            context,
            icon: HugeIcons.strokeRoundedUser,
            title: "Member Management",
            description: "Manage members, promote or demote roles.",
            onTap: () {
              Get.to(() => const BatchMembersScreen());
            },
          ),
          _buildListItem(
            context,
            icon: HugeIcons.strokeRoundedDownload02,
            title: "Download Member List",
            description: "Export the member list as a downloadable file.",
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (context) => const FeatureNotAvailableBottomSheet(),
              );
            },
          ),
          _buildListItem(
            context,
            icon: HugeIcons.strokeRoundedDelete01,
            title: "Delete Batch",
            description: "Permanently delete this batch.",
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                builder: (context) => const FeatureNotAvailableBottomSheet(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required VoidCallback onTap,
      }) {
    return Column(
      children: [
        ListTile(
          splashColor: primaryColor.withOpacity(0.1),
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon),
          ),
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            description,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: secondaryFontColor),
          ),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
        ),
        Divider(
          height: 1.5,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}
