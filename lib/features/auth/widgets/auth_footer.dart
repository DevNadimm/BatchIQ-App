import 'package:flutter/material.dart';
import 'package:batchiq_app/core/colors/colors.dart';

class AuthFooter extends StatelessWidget {
  final String label;
  final String actionText;
  final VoidCallback onTap;

  const AuthFooter({
    super.key,
    required this.label,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black54),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
