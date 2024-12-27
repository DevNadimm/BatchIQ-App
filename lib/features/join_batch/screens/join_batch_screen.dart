import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class JoinBatchScreen extends StatelessWidget {
  const JoinBatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            _buildFeatureSection(context),
            const SizedBox(height: 16),
            _buildBatchIDSection(context),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      forceMaterialTransparency: true,
      title: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://cdn3.pixelcut.app/7/20/uncrop_hero_bdf08a8ca6.jpg",
            ),
          ),
          const SizedBox(width: 10),
          _buildGreetingSection(),
        ],
      ),
    );
  }

  Widget _buildGreetingSection() {
    final currentHour = DateTime.now().hour;
    final greetingMessage = currentHour < 12
        ? 'Good Morning'
        : currentHour < 16
            ? 'Good Afternoon'
            : currentHour < 20
                ? 'Good Evening'
                : 'Good Night';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$greetingMessage 👋",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
        const Text(
          "Nadim Chowdhury",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildFeatureSection(BuildContext context) {
    final features = [
      "Personalized learning assignments",
      "Instant access to notices",
      "Collaborate with batchmates",
      "Track your progress effectively",
      "Access exclusive resources",
      "Get real-time updates and feedback",
    ];

    return _buildCard(
      context,
      title: "Why Join BatchIQ?",
      content: Column(
        children: features
            .map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: _buildFeatureRow(context, feature),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildFeatureRow(BuildContext context, String featureTitle) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green),
        const SizedBox(width: 8),
        Text(featureTitle, style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }

  Widget _buildBatchIDSection(BuildContext context) {
    return _buildCard(
      context,
      title: "Have Batch ID?",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Enter here to join",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: shadeColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "For eg: 01732134",
                      hintStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 12,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context,
      {required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}
