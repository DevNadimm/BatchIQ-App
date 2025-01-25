import 'package:batchiq_app/core/colors/colors.dart';
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
import 'package:batchiq_app/shimmer/home_screen_loading.dart';
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
    fetchAll();
  }

  Future<void> fetchAll() async {
    setState(() => isLoading = true);

    await _fetchUserData();
    await _fetchBatchInfo();
    await _fetchClassSchedules();

    setState(() => isLoading = false);
  }

  Future<void> _fetchUserData() async {
    final userController = UserController();
    final fetchedUserModel = await userController.fetchUserData();
    setState(() {
      userModel = fetchedUserModel;
    });
  }

  Future<void> _fetchBatchInfo() async {
    await BatchInfoController.instance.fetchBatchInfo(userModel!.batchId!);
  }

  Future<void> _fetchClassSchedules() async {
    await ClassScheduleController.instance.getClassSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isLoading,
      replacement: const HomeScreenLoading(),
      child: Scaffold(
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
          leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(HugeIcons.strokeRoundedMenu02),
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
        body: Column(
          children: [
            const HeaderSection(height: 85),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    GetBuilder<ClassScheduleController>(
                      builder: (controller) =>
                          TodaysTimeline(controller: controller),
                    ),
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
