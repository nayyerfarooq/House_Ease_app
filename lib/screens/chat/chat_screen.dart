import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';
import '../../main.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.primaryDarkColor,
        centerTitle: true,
        title: Text('Chat', style: TextStyle(color: AppColors.accentColor),),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Icon(Icons.chat_bubble_outline, size: 100, color: Colors.blue.shade800),
          SizedBox(height: 20),
          Text(
            'No Messages, yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            "You’ll find all your messages right here, Get started.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Spacer(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 3,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed(AppRoutes.home);
              break;
            case 1:
              Get.toNamed(AppRoutes.myAds);
              break;
            case 2:
              Get.toNamed(AppRoutes.myCart);
              break;
            case 3:
              Get.toNamed(AppRoutes.chat);
              break;
            case 4:
              Get.toNamed(AppRoutes.profile);
              break;
          }
        },
      ),
    );
  }
}