import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
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
        Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
