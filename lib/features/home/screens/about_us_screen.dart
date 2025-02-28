import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "About Us",
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  imageUrl:
                  'https://i.ibb.co.com/sdyfXrfz/Blue-Modern-Money-Managing-Mobile-App-Promotion-Facebook-Ad-page-0001.jpg',
                  placeholder: (context, url) =>
                  const ProgressIndicatorWidget(),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context: context,
              title: 'Welcome to BatchIQ',
              icon: Icons.school,
              content:
              'BatchIQ is the ultimate batch management solution designed for university students. '
                  'We simplify and enhance communication, organization, and collaboration within academic batches.',
            ),
            _buildDivider(),
            _buildSection(
              context: context,
              title: 'Our Vision',
              icon: Icons.visibility,
              content:
              'To empower university students with smart, efficient, and seamless batch management, '
                  'ensuring smooth coordination and enhanced productivity. '
                  'We aim to be the leading app in the education sector, trusted by students and educators alike.',
            ),
            _buildDivider(),
            _buildSection(
              context: context,
              title: 'Our Mission',
              icon: Icons.flag,
              content:
              'To create an environment that promotes productivity and collaboration by bringing students, '
                  'faculty, and staff together through innovative tools and a user-friendly interface.',
            ),
            _buildDivider(),
            _buildSection(
              context: context,
              title: 'Our Future',
              icon: Icons.rocket_launch,
              content:
              'We aim to expand BatchIQ with advanced features, AI-driven insights, and '
                  'cross-university integration, making it the go-to solution for student collaboration worldwide. '
                  'BatchIQ will continue to evolve with the latest technological advancements.',
            ),
            _buildDivider(),
            _buildSection(
              context: context,
              title: 'Our Values',
              icon: Icons.favorite,
              content:
              'Integrity, Innovation, Collaboration, and Excellence are the core values that guide us. '
                  'We believe in continuous improvement, ensuring that BatchIQ delivers the best experience for all users.',
            ),
            const SizedBox(height: 30),
            _buildVersionInfo(context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required String content,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryColor, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: secondaryFontColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Divider(color: Colors.grey.withOpacity(0.3), thickness: 1),
    );
  }

  Widget _buildVersionInfo({required BuildContext context}) {
    return Center(
      child: Column(
        children: [
          Text(
            "BatchIQ App",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            "Version 1.0.0",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: secondaryFontColor),
          ),
        ],
      ),
    );
  }
}
