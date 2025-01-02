import 'package:flutter/material.dart';

class AuthDivider extends StatelessWidget {
  final String label;

  const AuthDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(thickness: 1.5),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.black54),
        ),
        const SizedBox(width: 4),
        const Expanded(
          child: Divider(thickness: 1.5),
        ),
      ],
    );
  }
}
