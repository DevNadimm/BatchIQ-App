import 'package:flutter/material.dart';

class GridContent {
  final String name;
  final String userDescription;
  final String adminDescription;
  final String iconPath;
  final Color color;
  final VoidCallback onTapAdmin;
  final VoidCallback onUserTap;

  GridContent({
    required this.name,
    required this.iconPath,
    required this.color,
    required this.userDescription,
    required this.adminDescription,
    required this.onTapAdmin,
    required this.onUserTap,
  });
}

List<GridContent> gridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    adminDescription: "Manage assignments for all members.",
    iconPath: "assets/icons/assignment.png",
    color: Colors.green,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    adminDescription: "Manage calendar events for members.",
    iconPath: "assets/icons/calender.png",
    color: Colors.blue,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    adminDescription: "Post and manage announcements.",
    iconPath: "assets/icons/announcement.png",
    color: Colors.orange,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams and results.",
    adminDescription: "Manage exam schedules and results.",
    iconPath: "assets/icons/exam.png",
    color: Colors.red,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    adminDescription: "Send notifications to members.",
    iconPath: "assets/icons/notification.png",
    color: Colors.purple,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    adminDescription: "Manage all available resources.",
    iconPath: "assets/icons/resources.png",
    color: Colors.teal,
    onTapAdmin: () {},
    onUserTap: () {},
  ),
];
