import 'package:batchiq_app/core/colors/colors.dart';
import 'package:flutter/material.dart';

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  labelStyle: TextStyle(
      color: secondaryFontColor.withOpacity(0.9),
      fontSize: 16,
      fontWeight: FontWeight.w500),
  hintStyle: TextStyle(
    color: Colors.grey.shade600,
    fontSize: 14,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 1,
      color: primaryColor.withOpacity(0.4),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 1,
      color: primaryColor.withOpacity(0.4),
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 1.5,
      color: primaryColor.withOpacity(0.8),
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(
      width: 1,
      color: Colors.red.withOpacity(0.8),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      width: 1.5,
      color: Colors.red,
    ),
  ),
);
