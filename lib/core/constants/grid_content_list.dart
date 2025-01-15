import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class GridContent {
  final String name;
  final String userDescription;
  final String adminDescription;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  GridContent({
    required this.name,
    required this.icon,
    required this.color,
    required this.userDescription,
    required this.adminDescription,
    required this.onTap,
  });
}

List<GridContent> gridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    adminDescription: "Manage assignments for all users.",
    icon: HugeIcons.strokeRoundedAssignments,
    color: Colors.green,
    onTap: () {},
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    adminDescription: "Manage calendar events for users.",
    icon: HugeIcons.strokeRoundedTimeManagement,
    color: Colors.blue,
    onTap: () {},
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    adminDescription: "Post and manage announcements.",
    icon: HugeIcons.strokeRoundedSpeaker01,
    color: Colors.orange,
    onTap: () {},
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams and results.",
    adminDescription: "Manage exam schedules and results.",
    icon: HugeIcons.strokeRoundedTestTube,
    color: Colors.red,
    onTap: () {},
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    adminDescription: "Send notifications to users.",
    icon: HugeIcons.strokeRoundedNotification01,
    color: Colors.purple,
    onTap: () {},
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    adminDescription: "Manage all available resources.",
    icon: HugeIcons.strokeRoundedResourcesRemove,
    color: Colors.teal,
    onTap: () {},
  ),
];
