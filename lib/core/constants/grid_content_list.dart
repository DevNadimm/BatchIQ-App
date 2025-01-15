import 'package:batchiq_app/features/admin_dashboard/screens/assignment_admin_screen.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridContent {
  final String name;
  final String userDescription;
  final String adminDescription;
  final String iconPath;
  final Color color;
  final VoidCallback onTapAdmin;
  final VoidCallback onTapUser;

  GridContent({
    required this.name,
    required this.iconPath,
    required this.color,
    required this.userDescription,
    required this.adminDescription,
    required this.onTapAdmin,
    required this.onTapUser,
  });
}

List<GridContent> gridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    adminDescription: "Manage assignments for all members.",
    iconPath: "assets/icons/assignment.png",
    color: Colors.green,
    onTapAdmin: () => Get.to(const AssignmentAdminScreen()),
    onTapUser: () {},
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    adminDescription: "Manage calendar events for members.",
    iconPath: "assets/icons/calender.png",
    color: Colors.blue,
    onTapAdmin: () => Get.to(const HomeScreen()),
    onTapUser: () {},
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    adminDescription: "Post and manage announcements.",
    iconPath: "assets/icons/announcement.png",
    color: Colors.orange,
    onTapAdmin: () => Get.to(const HomeScreen()),
    onTapUser: () {},
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams.",
    adminDescription: "Manage exam schedules.",
    iconPath: "assets/icons/exam.png",
    color: Colors.red,
    onTapAdmin: () => Get.to(const HomeScreen()),
    onTapUser: () {},
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    adminDescription: "Send notifications to members.",
    iconPath: "assets/icons/notification.png",
    color: Colors.purple,
    onTapAdmin: () => Get.to(const HomeScreen()),
    onTapUser: () {},
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    adminDescription: "Manage all available resources.",
    iconPath: "assets/icons/resources.png",
    color: Colors.teal,
    onTapAdmin: () => Get.to(const HomeScreen()),
    onTapUser: () {},
  ),
];
