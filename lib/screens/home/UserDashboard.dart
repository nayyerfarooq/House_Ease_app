import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Controllers/BottomBarController.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';
class UserDashBoardScreen extends StatelessWidget {
  final BottomBarController _controller = Get.put(BottomBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return _controller.pages[_controller.selectedIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return FloatingNavbar(
          onTap: (int val) {
            _controller.onItemTapped(val);
          },
          currentIndex: _controller.selectedIndex.value,
          iconSize: 20,
          fontSize: 10.1,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          padding: const EdgeInsets.only(bottom: 8,top: 6),
          backgroundColor: AppColors.primaryDarkColor,
          selectedItemColor: Colors.black,
          selectedBackgroundColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            FloatingNavbarItem(icon: FontAwesomeIcons.houseMedical, title: 'Home'),
            FloatingNavbarItem(icon: FontAwesomeIcons.rectangleAd, title: 'MyAds'),
            FloatingNavbarItem(icon: FontAwesomeIcons.cartShopping, title: 'Cart'),
            FloatingNavbarItem(icon: FontAwesomeIcons.message, title: 'Chat'),
            FloatingNavbarItem(icon: FontAwesomeIcons.peopleRoof, title: 'Settings'),
          ],
        );
      }),
    );
  }
}
