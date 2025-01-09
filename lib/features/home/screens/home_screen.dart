import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/home/screens/add_friend_screen.dart';
import 'package:batchiq_app/features/home/widgets/header_section.dart';
import 'package:batchiq_app/features/home/widgets/navigation_drawer.dart';
import 'package:batchiq_app/features/home/widgets/todays_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(HugeIcons.strokeRoundedMenu02),
            );
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const AddFriendScreen(batchId: '',));
            },
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
