import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/services/notification_service.dart';
import 'package:batchiq_app/features/auth/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class LogoutDialog extends StatelessWidget {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final String batchId;

  LogoutDialog({super.key, required this.batchId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: const Column(
        children: [
          Icon(
            HugeIcons.strokeRoundedLogout03,
            color: Colors.red,
            size: 50,
          ),
          SizedBox(height: 15),
          Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text(
          'You will be logged out of your account and all your sessions will be terminated.',
          style: TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(100, 45),
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(width: 1, color: primaryColor.withOpacity(0.7)),
                  ),
                ),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () async {
                  await firebaseAuth.signOut();
                  if (firebaseAuth.currentUser == null) {
                    if (batchId != "No Batch Joined") {
                      await NotificationService.instance.unsubscribeFromTopic(batchId);
                    } else {
                      debugPrint("Skipping unsubscribe: batchId is empty.");
                    }
                    Get.to(const SignInScreen());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(100, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
