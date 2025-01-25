import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:batchiq_app/features/home/screens/announcement_screen.dart';
import 'package:batchiq_app/features/home/screens/assignment_screen.dart';
import 'package:batchiq_app/features/home/screens/my_calendar_screen.dart';
import 'package:batchiq_app/features/home/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<GridContent> userGridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    iconPath: IconImageName.assignment,
    color: Colors.green,
    onTapUser: () {
      Get.to(const AssignmentScreen());
    },
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    iconPath: IconImageName.calendar,
    color: Colors.blue,
    onTapUser: () {
      Get.to(const MyCalendarScreen());
    },
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    iconPath: IconImageName.announcement,
    color: Colors.orange,
    onTapUser: () {
      Get.to(const AnnouncementScreen());
    },
  ),
  GridContent(
    name: "Exams",
    userDescription: "View your upcoming exams.",
    iconPath: IconImageName.exam,
    color: Colors.red,
    onTapUser: () {},
  ),
  GridContent(
    name: "Notification",
    userDescription: "Stay updated with your notifications.",
    iconPath: IconImageName.notification,
    color: Colors.purple,
    onTapUser: () {
      Get.to(const NotificationScreen());
    },
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    iconPath: IconImageName.resources,
    color: Colors.teal,
    onTapUser: () {},
  ),
];
