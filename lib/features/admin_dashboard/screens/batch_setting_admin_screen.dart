import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildActionCard(
              context,
              icon: HugeIcons.strokeRoundedSetting07,
              title: "Info Management",
              description: "Update batch name, description, and view batch ID.",
              onTap: () {
                // Navigate to Info Management screen
              },
            ),
            const SizedBox(height: 16.0),
            _buildActionCard(
              context,
              icon: HugeIcons.strokeRoundedUser,
              title: "Member Management",
              description: "Manage members, promote or demote, and remove users.",
              onTap: () {
                // Navigate to Member Management screen
              },
            ),
            const SizedBox(height: 16.0),
            _buildActionCard(
              context,
              icon: HugeIcons.strokeRoundedDownload02,
              title: "Download Member List",
              description: "Export the member list as a downloadable file.",
              onTap: () {
                // Add download logic
              },
            ),
            const SizedBox(height: 16.0),
            _buildActionCard(
              context,
              icon: HugeIcons.strokeRoundedDelete01,
              title: "Delete Batch",
              description: "Permanently delete this batch.",
              onTap: () {
                // Add delete logic
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String description,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                child: Icon(icon, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: secondaryFontColor),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
