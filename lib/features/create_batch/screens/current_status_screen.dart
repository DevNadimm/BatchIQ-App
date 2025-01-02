import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

class CurrentStatusScreen extends StatefulWidget {
  const CurrentStatusScreen({super.key, required this.status});

  final String status;

  @override
  State<CurrentStatusScreen> createState() => _CurrentStatusScreenState();
}

class _CurrentStatusScreenState extends State<CurrentStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final statusData = getStatusData(widget.status);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      statusData.imageUrl,
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      statusData.title,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: statusData.color,
                              ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        statusData.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: secondaryFontColor,
                            ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  StatusData getStatusData(String status) {
    switch (status) {
      case "rejected":
        return StatusData(
          imageUrl: "assets/icons/reject.png",
          title: "Application Rejected",
          description:
              "Your application for Admin access has been rejected. Please check the email for the reason and address any issues. You can reapply after making the necessary changes.",
          color: Colors.red,
        );
      default:
        return StatusData(
          imageUrl: "assets/icons/pending.png",
          title: "Application Pending",
          description:
              "Your application for Admin access is currently under review. This process may take some time. We will notify you once a decision has been made. Please check back later for updates.",
          color: Colors.orange,
        );
    }
  }
}

class StatusData {
  final String imageUrl;
  final String title;
  final String description;
  final Color color;

  StatusData({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.color,
  });
}
