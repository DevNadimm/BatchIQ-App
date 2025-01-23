import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/utils/ui/progress_indicator.dart';
import 'package:batchiq_app/core/utils/ui/snackbar_message.dart';
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

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    final userController = UserController();
    final fetchedUserModel = await userController.fetchUserData();

    if (fetchedUserModel != null) {
      setState(() {
        userModel = fetchedUserModel;
      });

      if (userModel!.batchId != null) {
        await BatchInfoController.instance.fetchBatchInfo(userModel!.batchId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BatchInfoController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            title: Text(
              controller.batchInfoModel.name,
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
                  if (userModel != null && userModel!.batchId != null) {
                    Get.to(
                      InviteFriendScreen(
                        batchId: userModel!.batchId!,
                      ),
                    );
                  } else {
                    SnackBarMessage.errorMessage('Oops! We couldn’t load your data. Please try again later.');
                  }
                },
                icon: const Icon(HugeIcons.strokeRoundedUserAdd02),
              ),
            ],
          ),
          drawer: userModel != null
              ? BatchIQNavigationDrawer(userModel: userModel!)
              : const Center(
                  child: Text('We’re having trouble loading your information. Please refresh the app.'),
                ),
          body: controller.isLoading
              ? const Center(
                  child: ProgressIndicatorWidget(),
                )
              : const Column(
                  children: [
                    HeaderSection(height: 85),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 24),
                            TodaysTimeline(),
                            SizedBox(height: 24),
                            UserContentGrid(),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
