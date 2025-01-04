import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../../widgets/custom_button.dart';
import '../../utils/custom_clipper.dart';
import '../../routes/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordScreen({super.key});

  void _recoverPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Missing Email',
        'Please enter your email address.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade800,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      Get.snackbar(
        'Email Sent',
        'A password reset email has been sent to $email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.shade800,
        colorText: Colors.white,
      );
      Future.delayed(const Duration(seconds: 2), () {
        Get.toNamed(AppRoutes.login);
      });
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No account found with that email.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Please enter a valid email address.';
      } else {
        errorMessage = 'An error occurred. Please try again.';
      }

      Get.snackbar(
        'Password Reset Failed',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: CurveClipper(),
            child: Container(
              height: 100,
              color: Colors.blue.shade800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Text(
                  'Recover Your Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                const CustomTextWidget(
                 title:  'Enter your email address and we will send you instructions to reset your password.',
                  align: TextAlign.center,
                    color: Colors.grey,
                    size: 16,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'johndoe@gmail.com',
                    prefixIcon: Icon(Icons.email, color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Recover Password',
                  onPressed: _recoverPassword,
                  backgroundColor: Colors.blue.shade800,
                  textColor: Colors.white,
                  borderRadius: 10.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
