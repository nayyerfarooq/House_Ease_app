import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(
        'Missing Credentials',
        'Please enter both email and password.',
      );
      return;
    }

    try {
      // Handle login with Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Check if the email is verified
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        _showSnackbar('Login Successful', 'You have successfully logged in.');

        // Navigate to the home screen after showing the snackbar
        Future.delayed(Duration(seconds: 1), () {
          Get.toNamed(AppRoutes.home); // Navigate to home page
        });
      } else {
        _showSnackbar(
          'Email Not Verified',
          'Please verify your email before logging in.',
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e);

      _showSnackbar('Login Error', errorMessage);

      // Refocus the email field for specific errors
      if (e.code == 'invalid-email' || e.code == 'user-not-found') {
        FocusScope.of(Get.context!).requestFocus(FocusNode()); // Close keyboard
        _emailController.clear();
      } else if (e.code == 'wrong-password') {
        _passwordController.clear();
        FocusScope.of(Get.context!).requestFocus(FocusNode()); // Close keyboard
      }
    } catch (e) {
      _showSnackbar(
        'Login Error',
        'Something went wrong. Please try again later.',
      );
    }
  }

  // Function to show a snackbar with a custom message
  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade800,
      colorText: Colors.white,
    );
  }

  // Function to map FirebaseAuth exceptions to more user-friendly error messages
  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_image3.jpg', // Update with your background image path
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
                      'assets/images/logo4.png', // Replace with your image path
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    isPassword: true,
                    controller: _passwordController,
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
                    onPressed: _login,
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
