import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/ads/my_ads_page.dart';
import 'package:shift_ease_fyp/screens/chat/chat_screen.dart';
import 'package:shift_ease_fyp/screens/home/HomeScreen.dart';
import 'package:shift_ease_fyp/screens/mycart/my_cart_page.dart';
import 'package:shift_ease_fyp/screens/profile/profile_screen.dart';

class BottomBarController extends GetxController {
  var selectedIndex = 0.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
           HomeScreen(),
           MyAdsPage(),
           MyCartPage(),
           ChatScreen(),
           ProfileScreen(),
  ];
}