import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final VoidCallback onTap;
  final String imgPath;
  final String label;
  final BuildContext context;

  const SocialButton({
    super.key,
    required this.onTap,
    required this.imgPath,
    required this.label,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColor.withOpacity(0.4),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              scale: 25,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
