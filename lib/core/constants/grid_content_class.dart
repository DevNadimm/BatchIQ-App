import 'package:flutter/material.dart';

class GridContent {
  final String name;
  final String? userDescription;
  final String? adminDescription;
  final String iconPath;
  final Color color;
  final VoidCallback? onTapAdmin;
  final VoidCallback? onTapUser;

  GridContent({
    required this.name,
    required this.iconPath,
    required this.color,
    this.userDescription,
    this.adminDescription,
    this.onTapAdmin,
    this.onTapUser,
  });
}
