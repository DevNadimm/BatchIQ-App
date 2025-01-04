import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/auth/controller/user_controller.dart';
import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:batchiq_app/features/batch_management/join_batch/screens/join_batch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _userController = UserController();

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    final auth = FirebaseAuth.instance;
    await Future.delayed(const Duration(seconds: 3));

    if (auth.currentUser == null) {
      Get.offAll(() => const SignInScreen());
    } else {
      final user = await _userController.fetchUserData();

      if (user?.batchId != null) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.offAll(() => const JoinBatchScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/app_logos/batch-iq-logo-rounded.png',
              scale: 35,
            ),
            const SizedBox(height: 20),
            Text(
              "BatchIQ",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
