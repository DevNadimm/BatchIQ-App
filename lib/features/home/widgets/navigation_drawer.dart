import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:batchiq_app/features/home/controller/send_email.dart';
import 'package:batchiq_app/features/home/screens/developer_information_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class BatchIQNavigationDrawer extends StatelessWidget {
  const BatchIQNavigationDrawer({super.key});

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
                const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/images/avatar.jpg")),
                const SizedBox(height: 12),
                Text(
                  "Nadim Chowdhury",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "nadimchowdhury87@gmail.com",
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
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedDashboardBrowsing,
                  "Dashboard Overview (Admin)",
                  () {},
                ),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedUserAccount,
                  "Manage Profiles",
                  () {},
                ),
                Divider(color: Colors.grey.shade300),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedHelpSquare,
                  "Help & Feedback",
                  () {
                    sendEmail();
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
                  () {},
                ),
                _buildDrawerItem(
                  context,
                  HugeIcons.strokeRoundedUserGroup,
                  "About Us",
                  () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                // Handle logout
                final auth = FirebaseAuth.instance;
                await auth.signOut();
                if (auth.currentUser == null) {
                  Get.to(const SignInScreen());
                }
              },
              icon: const Icon(HugeIcons.strokeRoundedLogout03),
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
}
