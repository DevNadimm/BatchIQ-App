import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
import 'package:batchiq_app/features/admin_dashboard/controller/class_schedule_controller.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/auth/models/user_model.dart';
import 'package:batchiq_app/features/home/controller/batch_info_controller.dart';
import 'package:batchiq_app/features/home/screens/invite_friend_screen.dart';
import 'package:batchiq_app/features/home/widgets/header_section.dart';
import 'package:batchiq_app/features/home/widgets/navigation_drawer.dart';
import 'package:batchiq_app/features/home/widgets/todays_timeline.dart';
import 'package:batchiq_app/features/home/widgets/user_content_grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? userModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    setState(() => isLoading = true);

    try {
      final userController = UserController();
      final fetchedUserModel = await userController.fetchUserData();
      userModel = fetchedUserModel;

      await Future.wait([
        if (userModel?.batchId != null)
          BatchInfoController.instance.fetchBatchInfo(userModel!.batchId!),
        ClassScheduleController.instance.getClassSchedules(),
      ]);
    } catch (e) {
      SnackBarMessage.errorMessage('Failed to load data!');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: GetBuilder<BatchInfoController>(
          builder: (controller) => Text(
            controller.batchInfoModel.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(color: Colors.white),
          ),
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
              if (userModel != null && userModel!.batchId != null) {
                Get.to(
                  InviteFriendScreen(batchId: userModel!.batchId!),
                );
              } else {
                SnackBarMessage.errorMessage(
                  'Oops! We couldn’t load your data. Please try again later.',
                );
              }
            },
            icon: const Icon(HugeIcons.strokeRoundedUserAdd02),
          ),
        ],
      ),
      drawer: userModel != null
          ? BatchIQNavigationDrawer(userModel: userModel!)
          : const Center(
              child: Text(
                  'We’re having trouble loading your information. Please refresh the app.'),
            ),
      body: isLoading
          ? const Center(
              child: ProgressIndicatorWidget(),
            )
          : GetBuilder<ClassScheduleController>(
              builder: (controller) => Column(
                children: [
                  const HeaderSection(height: 85),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          TodaysTimeline(controller: controller),
                          const SizedBox(height: 24),
                          const UserContentGrid(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
