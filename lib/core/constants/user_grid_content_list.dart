import 'package:batchiq_app/core/constants/grid_content_class.dart';
import 'package:batchiq_app/core/constants/icon_image_name.dart';
import 'package:flutter/material.dart';

List<GridContent> userGridContentList = [
  GridContent(
    name: "Assignment",
    userDescription: "View and manage your assignments.",
    iconPath: IconImageName.assignment,
    color: Colors.green,
    onTapUser: () {},
  ),
  GridContent(
    name: "My Calendar",
    userDescription: "Track and organize your calendar events.",
    iconPath: IconImageName.calendar,
    color: Colors.blue,
    onTapUser: () {},
  ),
  GridContent(
    name: "Announcement",
    userDescription: "Check important announcements.",
    iconPath: IconImageName.announcement,
    color: Colors.orange,
    onTapUser: () {},
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
    onTapUser: () {},
  ),
  GridContent(
    name: "Resources",
    userDescription: "Access and manage your resources.",
    iconPath: IconImageName.resources,
    color: Colors.teal,
    onTapUser: () {},
  ),
];
