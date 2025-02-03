import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/announcement_screens/announcement_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/assignment_screens/assignment_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/class_schedule_screens/class_schedule_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/my_calender_screens/my_calender_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/notification_screens/notification_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/resources_screens/resources_admin_screen.dart';
import 'package:batchiq_app/features/admin_dashboard/screens/settings_screens/batch_setting_admin_screen.dart';
import 'package:batchiq_app/features/others/screens/under_maintenance_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GridContent> adminGridContentList = [
  GridContent(
    name: "Assignment",
    adminDescription: "Manage assignments for all members.",
    iconPath: IconImageName.assignment,
    color: const Color(0xFF1B5E20),
    onTapAdmin: () => Get.to(const AssignmentAdminScreen()),
  ),
  GridContent(
    name: "My Calendar",
    adminDescription: "Manage calendar events for members.",
    iconPath: IconImageName.calendar,
    color: const Color(0xFF1565C0),
    onTapAdmin: () => Get.to(const MyCalendarAdminScreen()),
  ),
  GridContent(
    name: "Class Schedule",
    adminDescription: "Manage class schedules.",
    iconPath: IconImageName.classSchedule,
    color: const Color(0xFF00838F),
    onTapAdmin: () => Get.to(const ClassScheduleAdminScreen()),
  ),
  GridContent(
    name: "Exam Schedule",
    adminDescription: "Manage exam schedules.",
    iconPath: IconImageName.exam,
    color: const Color(0xFFD32F2F),
    onTapAdmin: () => Get.to(const UnderMaintenanceScreen()),
  ),
  GridContent(
    name: "Announcement",
    adminDescription: "Post and manage announcements.",
    iconPath: IconImageName.announcement,
    color: const Color(0xFFFF7043),
    onTapAdmin: () => Get.to(const AnnouncementAdminScreen()),
  ),
  GridContent(
    name: "Notification",
    adminDescription: "Send notifications to members.",
    iconPath: IconImageName.notification,
    color: const Color(0xFF8E24AA),
    onTapAdmin: () => Get.to(const NotificationAdminScreen()),
  ),
  GridContent(
    name: "Course",
    adminDescription: "Manage course list & faculty contacts.",
    iconPath: IconImageName.course,
    color: const Color(0xFF3F51B5),
    onTapAdmin: () => Get.to(() => const UnderMaintenanceScreen()),
  ),
  GridContent(
    name: "Resources",
    adminDescription: "Manage all available resources.",
    iconPath: IconImageName.resources,
    color: const Color(0xFF00796B),
    onTapAdmin: () => Get.to(() => const ResourcesAdminScreen()),
  ),
  GridContent(
    name: "Job & Internship",
    adminDescription: "Manage job & internship postings.",
    iconPath: IconImageName.jobInternship,
    color: const Color(0xFF0097A7),
    onTapAdmin: () => Get.to(() => const UnderMaintenanceScreen()),
  ),
  GridContent(
    name: "Batch Settings",
    adminDescription: "Manage and configure batch settings.",
    iconPath: IconImageName.batchSettings,
    color: const Color(0xFF512DA8),
    onTapAdmin: () => Get.to(const BatchSettingAdminScreen()),
  ),
];
