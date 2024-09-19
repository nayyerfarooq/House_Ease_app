import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_image3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Content on top of the background
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/logo4.png',
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    isPassword: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    text: 'Login',
                    backgroundColor: Colors.blue.shade800,
                    onPressed: () {
                      Get.toNamed(AppRoutes.home);
                    },
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Or continue with',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  SizedBox(height: 30),
                  _buildSocialButton(
                    context,
                    'Continue with Apple',
                    Icons.apple,
                    Colors.black,
                  ),
                  SizedBox(height: 30),
                  _buildSocialButton(
                    context,
                    'Continue with Google',
                    Icons.g_mobiledata,
                    Colors.white,
                    isGoogle: true,
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, String text, IconData icon, Color backgroundColor, {bool isGoogle = false}) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: isGoogle ? null : Colors.white),
      label: Text(
        text,
        style: TextStyle(color: isGoogle ? Colors.black : Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: isGoogle ? Colors.black : Colors.white,
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        side: isGoogle ? BorderSide(color: Colors.grey) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
