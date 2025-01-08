import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/home/widgets/header_section.dart';
import 'package:batchiq_app/features/home/widgets/navigation_drawer.dart';
import 'package:batchiq_app/features/home/widgets/todays_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: Text(
          "PCIU CSE 33 B1",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {

          },
          icon: const Icon(HugeIcons.strokeRoundedMenu02),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(HugeIcons.strokeRoundedUserAdd02),
          ),
        ],
      ),
      drawer: const BatchIQNavigationDrawer(),
      body: const Column(
        children: [
          HeaderSection(height: 85),
          SizedBox(height: 24),
          TodaysTimeline(),
        ],
      ),
    );
  }
}
