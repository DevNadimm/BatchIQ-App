import 'package:batchiq_app/features/join_batch/widgets/batch_id_section.dart';
import 'package:batchiq_app/features/join_batch/widgets/create_batch_section.dart';
import 'package:batchiq_app/features/join_batch/widgets/custom_card.dart';
import 'package:batchiq_app/features/join_batch/widgets/feature_row.dart';
import 'package:batchiq_app/features/join_batch/widgets/greeting_section.dart';
import 'package:flutter/material.dart';

class JoinBatchScreen extends StatelessWidget {
  const JoinBatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                "https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg",
              ),
            ),
            SizedBox(width: 10),
            GreetingSection(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildFeatureSection(context),
            const SizedBox(height: 16),
            _buildBatchIDSection(context),
            const SizedBox(height: 16),
            const CreateBatchSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureSection(BuildContext context) {
    final features = [
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

  Widget _buildBatchIDSection(BuildContext context) {
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
