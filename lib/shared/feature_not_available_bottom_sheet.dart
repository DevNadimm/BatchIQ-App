import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeatureNotAvailableBottomSheet extends StatelessWidget {
  const FeatureNotAvailableBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Spacer(),
              IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Image.asset(
            IconImageName.featureNotAvailable,
            height: 80,
          ),
          const SizedBox(height: 24),
          Text(
            "Feature Not Available",
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            "We're sorry! This feature is currently unavailable. Please check back later.",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: secondaryFontColor),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
