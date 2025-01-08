import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/batch_id_section.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/create_batch_section.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/custom_card.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/feature_row.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/greeting_section.dart';
import 'package:batchiq_app/features/profile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinBatchScreen extends StatefulWidget {
  const JoinBatchScreen({super.key});

  @override
  State<JoinBatchScreen> createState() => _JoinBatchScreenState();
}

class _JoinBatchScreenState extends State<JoinBatchScreen> {
  final _userController = UserController();
  bool isUserAdmin = false;
  String? userName;
  String? uid;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    final user = await _userController.fetchUserData();
    setState(() {
      isUserAdmin = user?.role == "admin";
      userName = user?.name ?? "Guest";
      uid = user?.uid ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.to(const ProfileScreen());
              },
              child: CircleAvatar(
                backgroundColor: primaryColor,
                child: Text(
                  userName != null && userName!.isNotEmpty
                      ? userName![0].toUpperCase()
                      : "G",
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 10),
            GreetingSection(name: userName ?? "Guest"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildFeatureSection(),
            const SizedBox(height: 16),
            _buildBatchIDSection(uid ?? ""),
            const SizedBox(height: 16),
            CreateBatchSection(
              isUserAdmin: isUserAdmin,
              uid: uid ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection() {
    const features = [
      "Manage assignments & deadlines",
      "Access notices & announcements",
      "Real-time updates & notifications",
      "Collaborate with batchmates",
      "Track progress & deadlines",
      "View & manage class schedule",
    ];

    return CustomCard(
      title: "Why Join BatchIQ?",
      content: Column(
        children: features
            .map(
              (feature) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: FeatureRow(featureTitle: feature),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildBatchIDSection(String uid) {
    return CustomCard(
      title: "Have Batch ID?",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter here to join",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          BatchIDSection(userId: uid,),
        ],
      ),
    );
  }
}
