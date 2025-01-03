import 'package:flutter/material.dart';

class FeatureRow extends StatelessWidget {
  final String featureTitle;

  const FeatureRow({super.key, required this.featureTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            featureTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
