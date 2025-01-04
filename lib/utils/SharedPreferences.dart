import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shift_ease_fyp/screens/auth/login_screen.dart';

// for user email only
Future<void> saveData(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('email', value);
}

Future<String?> getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email');
}

Future<void> clearData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  Get.offAll(LoginScreen());
}


Future<void> saveUserData(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(userData);
  await prefs.setString('userData', jsonString);
}

Future<Map<String, dynamic>?> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString('userData');

  if (jsonString != null) {
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }
  return null;
}

Future<void> clearUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userData');
  Get.offAll(LoginScreen());
}
