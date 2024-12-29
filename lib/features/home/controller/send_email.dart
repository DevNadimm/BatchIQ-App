import 'package:url_launcher/url_launcher.dart';

// Email for User Help & Feedback
Future<void> sendEmail() async {
  launchUrl(Uri.parse("mailto:nadimm.dev@gmail.com?subject=BatchIQ: User Feedback"));
}
