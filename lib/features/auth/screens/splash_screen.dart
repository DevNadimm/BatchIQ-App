import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:batchiq_app/features/join_batch/screens/join_batch_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
      Get.offAll(() => const JoinBatchScreen());
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
              'assets/logos/google.png',
             scale: 8,
            ),
            const SizedBox(height: 20),
            Text("BatchIQ", style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
