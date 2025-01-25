import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/apply_for_admin_screen.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/create_batch_screen.dart';
import 'package:batchiq_app/features/batch_management/create_batch/screens/current_status_screen.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/batch_id_section.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/custom_card.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/feature_row.dart';
import 'package:batchiq_app/features/batch_management/join_batch/widgets/greeting_section.dart';
import 'package:batchiq_app/features/profile/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JoinBatchScreen extends StatefulWidget {
  const JoinBatchScreen({super.key});

  @override
  State<JoinBatchScreen> createState() => _JoinBatchScreenState();
}

class _JoinBatchScreenState extends State<JoinBatchScreen> {
  final _userController = UserController();
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
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  onTapCreateBatch();
                },
                child: const Text(
                  "Create a Batch",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
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
          BatchIDSection(userId: uid),
        ],
      ),
    );
  }

  void onTapCreateBatch () async {
    final userController = UserController();
    final user = await userController.fetchUserData();
    final isUserAdmin = user?.role == 'admin';

    if (isUserAdmin) {
      Get.to(const CreateBatchScreen());
    } else {
      final firestore = FirebaseFirestore.instance;
      final result = await firestore
          .collection("AdminApplications")
          .doc(uid)
          .get();
      if (result.exists) {
        final data = result.data() as Map<String, dynamic>;
        final status = data["status"];
        Get.to(CurrentStatusScreen(status: status));
      } else {
        Get.to(const ApplyForAdminScreen());
      }
    }
  }
}
