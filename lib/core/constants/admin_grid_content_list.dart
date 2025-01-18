import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/announcement_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/assignment_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/batch_setting_admin_screen.dart';
import 'package:batchiq_app/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GridContent> adminGridContentList = [
  GridContent(
    name: "Assignment",
    adminDescription: "Manage assignments for all members.",
    iconPath: IconImageName.assignment,
    color: Colors.green,
    onTapAdmin: () => Get.to(const AssignmentAdminScreen()),
  ),
  GridContent(
    name: "My Calendar",
    adminDescription: "Manage calendar events for members.",
    iconPath: IconImageName.calendar,
    color: Colors.blue,
    onTapAdmin: () => Get.to(const HomeScreen()),
  ),
  GridContent(
    name: "Class Schedule",
    adminDescription: "Manage class schedules.",
    iconPath: IconImageName.classSchedule,
    color: Colors.blueGrey,
    onTapAdmin: () => Get.to(const HomeScreen()),
  ),
  GridContent(
    name: "Exam Schedule",
    adminDescription: "Manage exam schedules.",
    iconPath: IconImageName.exam,
    color: Colors.red,
    onTapAdmin: () => Get.to(const HomeScreen()),
  ),
  GridContent(
    name: "Announcement",
    adminDescription: "Post and manage announcements.",
    iconPath: IconImageName.announcement,
    color: Colors.orange,
    onTapAdmin: () => Get.to(const AnnouncementAdminScreen()),
  ),
  GridContent(
    name: "Notification",
    adminDescription: "Send notifications to members.",
    iconPath: IconImageName.notification,
    color: Colors.purple,
    onTapAdmin: () => Get.to(const HomeScreen()),
  ),
  GridContent(
    name: "Resources",
    adminDescription: "Manage all available resources.",
    iconPath: IconImageName.resources,
    color: Colors.teal,
    onTapAdmin: () => Get.to(const HomeScreen()),
  ),
  GridContent(
    name: "Batch Settings",
    adminDescription: "Manage and configure batch settings.",
    iconPath: IconImageName.batchSettings,
    color: Colors.deepPurpleAccent,
    onTapAdmin: () => Get.to(const BatchSettingAdminScreen()),
  )

];
