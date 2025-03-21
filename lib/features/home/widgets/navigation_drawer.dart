import 'package:batchiq_app/features/admin_dashboard/screens/admin_dashboard_screen.dart';
import 'package:batchiq_app/features/auth/models/user_model.dart';
import 'package:batchiq_app/features/home/screens/about_us_screen.dart';
import 'package:batchiq_app/features/profile/screens/profile_screen.dart';
import 'package:batchiq_app/features/home/screens/developer_information_screen.dart';
import 'package:batchiq_app/shared/dialogs/logout_dialog.dart';
import 'package:batchiq_app/core/utils/launch_url.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';

class BatchIQNavigationDrawer extends StatelessWidget {
  const BatchIQNavigationDrawer({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: shadeColor,
                  child: Text(
                    userModel.name[0],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userModel.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  userModel.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                if (userModel.role == "admin")
                  _buildDrawerItem(
                    context,
                    HugeIcons.strokeRoundedDashboardBrowsing,
                    "Admin Dashboard",
                    () {
                      Get.to(const AdminDashboardScreen());
                    },
                  ),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedUserAccount,
                  "Manage Profiles",
                  () {
                    Get.to(const ProfileScreen());
                  },
                ),
                Divider(color: Colors.grey.shade300),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedHelpSquare,
                  "Help & Feedback",
                  () {
                    LaunchURL.sendEmail("User Feedback");
                  },
                ),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedDeveloper,
                  "Developer Information",
                  () {
                    Get.to(const DeveloperInformationScreen());
                  },
                ),
                Divider(color: Colors.grey.shade300),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedShare01,
                  "Share App",
                  () {
                    shareApp();
                  },
                ),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedUserGroup,
                  "About Us",
                  () {
                    Get.to(() => const AboutUsScreen());
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                Get.dialog(LogoutDialog(
                  batchId: userModel.batchId ?? "",
                ));
              },
              icon: const Icon(
                HugeIcons.strokeRoundedLogout03,
                color: Colors.white,
              ),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            HugeIcon(
              icon: icon,
              color: primaryFontColor.withOpacity(0.8),
              size: 22,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: primaryFontColor.withOpacity(0.8),
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void shareApp() async {
    final result = await Share.share(
        '🎓 BatchIQ makes uni life easier!\n\nStay organized and never miss deadlines with BatchIQ. Manage assignments, track progress, access notices, and stay updated in real-time.\n\nGet it now: https://drive.google.com/file/d/1iXz9wj4gdHZMfYCFrnik_scml3fWuBtb/view?usp=sharing',
        subject: 'BatchIQ - Uni Batch Management App'
    );

    if (result.status == ShareResultStatus.success) {
      debugPrint('Successful!');
    }
  }
}
