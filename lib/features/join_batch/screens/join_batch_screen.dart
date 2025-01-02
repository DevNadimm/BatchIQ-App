import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/join_batch/widgets/batch_id_section.dart';
import 'package:batchiq_app/features/join_batch/widgets/create_batch_section.dart';
import 'package:batchiq_app/features/join_batch/widgets/custom_card.dart';
import 'package:batchiq_app/features/join_batch/widgets/feature_row.dart';
import 'package:batchiq_app/features/join_batch/widgets/greeting_section.dart';
import 'package:flutter/material.dart';

class JoinBatchScreen extends StatefulWidget {
  const JoinBatchScreen({super.key});

  @override
  State<JoinBatchScreen> createState() => _JoinBatchScreenState();
}

class _JoinBatchScreenState extends State<JoinBatchScreen> {
  final _userController = UserController();
  bool isUserAdmin = false;
  String? userName;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg"),
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
            _buildBatchIDSection(),
            const SizedBox(height: 16),
            CreateBatchSection(isUserAdmin: isUserAdmin),
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

  Widget _buildBatchIDSection() {
    return const CustomCard(
      title: "Have Batch ID?",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter here to join",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          SizedBox(height: 4),
          BatchIDSection(),
        ],
      ),
    );
  }
}
