import 'package:batchiq_app/shared/url_launcher/launch_url.dart';
import 'package:flutter/material.dart';

class ProfileSocialSection extends StatelessWidget {
  const ProfileSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(
          assetPath: "assets/logos/facebook.png",
          onTap: () {
            LaunchURL.launchFacebook();
          },
        ),
        const SizedBox(width: 12),
        _socialIcon(
          assetPath: "assets/logos/twitter.png",
          onTap: () {
            LaunchURL.launchTwitter();
          },
        ),
        const SizedBox(width: 12),
        _socialIcon(
          assetPath: "assets/logos/linkedin.png",
          onTap: () {
            LaunchURL.launchLinkedIn();
          },
        ),
        const SizedBox(width: 12),
        _socialIcon(
          assetPath: "assets/logos/github.png",
          onTap: () {
            LaunchURL.launchGithub();
          },
        ),
      ],
    );
  }

  Widget _socialIcon({required String assetPath, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Image.asset(
          assetPath,
          scale: 20,
        ),
      ),
    );
  }
}
