import 'package:batchiq_app/core/colors/colors.dart';
import 'package:batchiq_app/core/constants/icons_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendScreen extends StatelessWidget {
  const InviteFriendScreen({super.key, required this.batchId});

  final String batchId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Invite Friend",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(backArrow),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.withOpacity(0.2),
            height: 1.5,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share your Batch ID with your friend so they can join and become part of the batch.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Batch ID",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              batchId,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: batchId));
                          },
                          icon: const Icon(
                            HugeIcons.strokeRoundedCopy01,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Share.share(
                    'You’re invited to join our batch on BatchIQ!\n\nStay connected, manage assignments, track progress, and never miss important updates.\n\nBatch ID: $batchId\n\nJoin us now: https://drive.google.com/file/d/1iXz9wj4gdHZMfYCFrnik_scml3fWuBtb/view?usp=sharing',
                    subject: 'BatchIQ - Join Our Batch',
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(HugeIcons.strokeRoundedShare01, color: Colors.white,),
                    SizedBox(width: 06),
                    Text(
                      "Invite Friend",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
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
