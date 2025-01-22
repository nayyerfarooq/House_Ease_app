import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/AdminMessageRelated/Views/admin_chat_screen.dart';
import '../../Controllers/userDataController.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        centerTitle: true,
        title: const CustomTextWidget(
          title: 'Chat',
          color: AppColors.accentColor,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final userId = userController.userData['id'].toString();
        final userName =  userController.userData['username'].toString();
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Icon(Icons.chat_bubble_outline, size: 100, color: Colors.blue.shade800),
            const SizedBox(height: 20),
            const CustomTextWidget(
              title: 'No Messages, yet',
              size: 20, weight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            const CustomTextWidget(
              title: "You’ll find all your messages right here. Get started.",
              align: TextAlign.center,
              size: 16, color: Colors.grey,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: () {
                Get.to(() => AdminChatScreen(userId: userId, userName: userName,));
                            },
              child: const CustomTextWidget(
                title: 'Chat with Admin',
                size: 18,
                color: AppColors.accentColor,
              ),
            ),
            const Spacer(),
          ],
        );
      }),
    );
  }
}
