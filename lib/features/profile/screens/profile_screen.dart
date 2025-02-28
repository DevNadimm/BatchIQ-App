import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/launch_url.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/profile/controller/profile_controller.dart';
import 'package:batchiq_app/features/profile/widgets/leave_batch_dialog.dart';
import 'package:batchiq_app/shared/dialogs/logout_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;
  String? name;
  String? email;
  String? role;
  String? batchId;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
    setState(() => isLoading = true);

    try {
      final UserController user = UserController();
      final userData = await user.fetchUserData();

      setState(() {
        name = userData?.name ?? "N/A";
        email = userData?.email ?? "N/A";
        role = userData?.role.toUpperCase() ?? "N/A";
        batchId = (userData?.batchId?.isEmpty ?? true) ? "No Batch Joined" : userData!.batchId!;
      });
    } catch (e) {
      setState(() {
        name = "Error";
        email = "Error";
        role = "Error";
        batchId = "Error";
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Visibility(
          visible: !isLoading,
          replacement: const ProgressIndicatorWidget(),
          child: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 50),
                  _buildProfileHeader(),
                  const SizedBox(height: 20),
                  _buildInfoCards(),
                  const SizedBox(height: 20),
                  _buildOptionsList(),
                ],
              ),
              Positioned(
                left: 0,
                top: 0,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(backArrow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: Text(
                name != null && name!.isNotEmpty ? name![0].toUpperCase() : "G",
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            CircleAvatar(
              radius: 18,
              backgroundColor: shadeColor,
              child: IconButton(
                icon: Icon(HugeIcons.strokeRoundedEdit02,
                    color: primaryColor, size: 16),
                onPressed: () {
                  // Add edit functionality here
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(name ?? "Loading...",
            style: Theme.of(context).textTheme.displaySmall),
        const SizedBox(height: 4),
        Text(email ?? "Loading...",
            style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildCard(title: "Role", value: role ?? "N/A"),
          const SizedBox(height: 12),
          _buildCard(
            title: "Batch ID",
            value: batchId ?? "No Batch Joined",
            isBatchIdCard: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    bool isBatchIdCard = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
          isBatchIdCard
              ? batchId == "No Batch Joined"
              ? const SizedBox.shrink()
              : Column(
            children: [
              const Divider(height: 1),
              GetBuilder<ProfileController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.isLoading,
                      replacement: const Padding(
                        padding: EdgeInsets.all(16),
                        child: ProgressIndicatorWidget(size: 20),
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Get.dialog(LeaveBatchDialog(batchId: batchId ?? ""));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                HugeIcons.strokeRoundedLogout03,
                                color: Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 15),
                              Text(
                                "Leave Batch",
                                style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              ),
            ],
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 10,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildListTile(
            title: "Edit Profile",
            icon: HugeIcons.strokeRoundedEdit02,
            onTap: () {},
          ),
          _buildListTile(
            title: "Notifications",
            icon: HugeIcons.strokeRoundedNotification02,
            onTap: () {},
          ),
          _buildListTile(
            title: "Help & Support",
            icon: HugeIcons.strokeRoundedHelpSquare,
            onTap: () {
              LaunchURL.sendEmail("Facing an Issue");
            },
          ),
          const Divider(),
          _buildListTile(
            title: "Logout",
            icon: HugeIcons.strokeRoundedLogout03,
            onTap: () async {
              Get.dialog(LogoutDialog(
                batchId: batchId ?? "",
              ));
            },
            iconColor: Colors.red,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = const Color(0xff1462a4),
    Color textColor = const Color(0xff0b132b),
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
