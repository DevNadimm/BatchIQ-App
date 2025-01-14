import 'package:flutter/cupertino.dart';
import 'package:hugeicons/hugeicons.dart';

class GridContent {
  final String name;
  final IconData icon;
  final VoidCallback onTap;

  GridContent({
    required this.name,
    required this.icon,
    required this.onTap,
  });
}

List<GridContent> gridContentList = [
  GridContent(
    name: "Assignment",
    icon: HugeIcons.strokeRoundedAssignments,
    onTap: () {},
  ),
  GridContent(
    name: "My Calendar",
    icon: HugeIcons.strokeRoundedTimeManagement,
    onTap: () {},
  ),
  GridContent(
    name: "Announcement",
    icon: HugeIcons.strokeRoundedSpeaker01,
    onTap: () {},
  ),
  GridContent(
    name: "Exams",
    icon: HugeIcons.strokeRoundedTestTube,
    onTap: () {},
  ),
  GridContent(
    name: "Notification",
    icon: HugeIcons.strokeRoundedNotification01,
    onTap: () {},
  ),
  GridContent(
    name: "Resources",
    icon: HugeIcons.strokeRoundedResourcesRemove,
    onTap: () {},
  ),
];
