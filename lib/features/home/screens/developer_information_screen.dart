import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/icons_name.dart';
import 'package:batchiq_app/features/home/widgets/profile_social_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeveloperInformationScreen extends StatelessWidget {
  const DeveloperInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(backArrow),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: Image.asset(
                  height: 140,
                  "assets/images/developer_profile.jpg",
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                "Nadim Chowdhury",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                "Flutter Developer",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: secondaryFontColor),
              ),
            ),
            const SizedBox(height: 24),
            const ProfileSocialSection(),
          ],
        ),
      ),
    );
  }
}
