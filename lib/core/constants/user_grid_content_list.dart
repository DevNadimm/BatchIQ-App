import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:batchiq_app/features/home/screens/announcement_screen.dart';
import 'package:batchiq_app/features/home/screens/assignment_screen.dart';
import 'package:batchiq_app/features/home/screens/class_schedule_screen.dart';
import 'package:batchiq_app/features/home/screens/my_calendar_screen.dart';
import 'package:batchiq_app/features/home/screens/notification_screen.dart';
import 'package:batchiq_app/features/others/screens/under_maintenance_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GridContent> userGridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    iconPath: IconImageName.assignment,
    color: const Color(0xFF1B5E20),
    onTapUser: () => Get.to(const AssignmentScreen()),
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    iconPath: IconImageName.calendar,
    color: const Color(0xFF1565C0),
    onTapUser: () => Get.to(const MyCalendarScreen()),
  ),
  GridContent(
    name: "Class Schedule",
    userDescription: "View your class timetable.",
    iconPath: IconImageName.classSchedule,
    color: const Color(0xFF00838F),
    onTapUser: () => Get.to(const ClassScheduleScreen()),
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams.",
    iconPath: IconImageName.exam,
    color: const Color(0xFFD32F2F),
    onTapUser: () => Get.to(() => const UnderMaintenanceScreen()),
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    iconPath: IconImageName.announcement,
    color: const Color(0xFFFF7043),
    onTapUser: () => Get.to(const AnnouncementScreen()),
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    iconPath: IconImageName.notification,
    color: const Color(0xFF8E24AA),
    onTapUser: () => Get.to(const NotificationScreen()),
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    iconPath: IconImageName.resources,
    color: const Color(0xFF00796B),
    onTapUser: () => Get.to(() => const UnderMaintenanceScreen()),
  ),
  GridContent(
    name: "Job & Internship",
    userDescription: "Explore jobs & internships.",
    iconPath: IconImageName.jobInternship,
    color: const Color(0xFF0097A7),
    onTapUser: () => Get.to(() => const UnderMaintenanceScreen()),
  ),
];
