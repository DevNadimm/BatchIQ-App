import 'package:url_launcher/url_launcher.dart';

class LaunchURL {
  static const String facebookURL = "https://www.facebook.com/nadimm.dev";
  static const String linkedinURL = "https://www.linkedin.com/in/devnadimm";
  static const String githubURL = "https://github.com/DevNadimm";
  static const String twitterURL = "https://twitter.com/nadimm.dev";

  static Future<void> launchFacebook() async {
    if (!await launchUrl(Uri.parse(facebookURL))) {
      throw Exception('Could not launch $facebookURL');
    }
  }

  static Future<void> launchLinkedIn() async {
    if (!await launchUrl(Uri.parse(linkedinURL))) {
      throw Exception('Could not launch $linkedinURL');
    }
  }

  static Future<void> launchGithub() async {
    if (!await launchUrl(Uri.parse(githubURL))) {
      throw Exception('Could not launch $githubURL');
    }
  }

  static Future<void> launchTwitter() async {
    if (!await launchUrl(Uri.parse(twitterURL))) {
      throw Exception('Could not launch $twitterURL');
    }
  }

  static Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> sendEmail() async {
    launchUrl(Uri.parse("mailto:nadimm.dev@gmail.com?subject=BatchIQ: User Feedback"));
  }
}
