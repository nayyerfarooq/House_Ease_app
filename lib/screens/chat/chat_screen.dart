import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.primaryDarkColor,
        centerTitle: true,
        title: const CustomTextWidget(
          title: 'Chat',
            color: AppColors.accentColor
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
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
            title: "You’ll find all your messages right here, Get started.",
            align: TextAlign.center,
            size: 16, color: Colors.grey,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}