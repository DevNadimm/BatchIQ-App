import 'package:batchiq_app/features/home/controller/send_email.dart';
import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';

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
                  backgroundImage: NetworkImage(
                    "https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg",
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Nadim Chowdhury",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  "nadimchowdhury87@gmail.com",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(context, Icons.dashboard,
                    "Dashboard Overview (Admin)", () {}),
                _buildDrawerItem(
                    context, Icons.person, "Manage Profiles", () {}),
                Divider(color: Colors.grey.shade300),
                _buildDrawerItem(
                    context, Icons.feedback, "Help & Feedback", () {
                  sendEmail();
                }),
                _buildDrawerItem(
                    context, Icons.code, "Developer Information", () {}),
                Divider(color: Colors.grey.shade300),
                _buildDrawerItem(context, Icons.share, "Share App", () {}),
                _buildDrawerItem(context, Icons.info, "About Us", () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Handle logout
              },
              icon: const Icon(Icons.logout),
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
            Icon(
              icon,
              color: primaryFontColor.withOpacity(0.8),
              size: 20,
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
