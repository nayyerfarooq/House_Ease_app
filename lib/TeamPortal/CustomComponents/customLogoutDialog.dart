import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/Pages/TeamMemberLogin.dart';
import 'package:shift_ease_fyp/TeamPortal/SharedPreferences/clearTeamMemberData.dart';
import '../../widgets/CustomTextWidget.dart';
import '../../widgets/custom_snakbar.dart';

void teamMemberLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 40, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const CustomTextWidget(
                title: 'Already leaving?',
                size: 18,
                weight: FontWeight.bold,
                color: Colors.white,
              ),
              const SizedBox(height: 10), // Spacing
              const CustomTextWidget(
                title: 'Are you sure you want to logout?',
                color: Colors.white70,
                align: TextAlign.center,
              ),
              const SizedBox(height: 20), // Spacing
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await clearTeamMemberLoginData();
                        Get.offAll(TeamMemberLoginPage());
                      } catch (e) {
                        showErrorSnackbar(e.toString());
                      }
                    },
                    child: const Text('Yes, Logout'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}