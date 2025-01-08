import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const _userKey = "user-key";

  static Future<void> saveUser({required Map<String, dynamic> userBody}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String encodedData = jsonEncode(userBody);
      await preferences.setString(_userKey, encodedData);
    } catch (e) {
      debugPrint("Error saving user data: $e");
    }
  }

  static Future<Map<String, dynamic>?> getUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userData = preferences.getString(_userKey);
      if (userData != null) {
        final decodedData = jsonDecode(userData) as Map<String, dynamic>;
        return decodedData;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Error retrieving user data: $e");
      return null;
    }
  }

  static Future<void> clearUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove(_userKey);
    } catch (e) {
      debugPrint("Error clearing user data: $e");
    }
  }
}
