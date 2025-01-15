import 'package:flutter/material.dart';

class GridContent {
  final String name;
  final String userDescription;
  final String adminDescription;
  final String iconPath;
  final Color color;
  final VoidCallback onTap;

  GridContent({
    required this.name,
    required this.iconPath,
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
    adminDescription: "Manage assignments for all members.",
    iconPath: "assets/icons/assignment.png",
    color: Colors.green,
    onTap: () {},
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    adminDescription: "Manage calendar events for members.",
    iconPath: "assets/icons/calender.png",
    color: Colors.blue,
    onTap: () {},
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    adminDescription: "Post and manage announcements.",
    iconPath: "assets/icons/announcement.png",
    color: Colors.orange,
    onTap: () {},
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams and results.",
    adminDescription: "Manage exam schedules and results.",
    iconPath: "assets/icons/exam.png",
    color: Colors.red,
    onTap: () {},
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    adminDescription: "Send notifications to members.",
    iconPath: "assets/icons/notification.png",
    color: Colors.purple,
    onTap: () {},
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    adminDescription: "Manage all available resources.",
    iconPath: "assets/icons/resources.png",
    color: Colors.teal,
    onTap: () {},
  ),
];
