import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../utils/custom_clipper.dart';
import '../../widgets/social_media_button.dart'; // Import the SocialMediaButton widget
import '../../widgets/custom_text_field.dart'; // Import the CustomTextField widget
import '../../widgets/custom_button.dart'; // Import the CustomButton widget

class SignUpScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _signUp() async {
    String fullName = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Send email verification
        User? user = _auth.currentUser;
        if (user != null && !user.emailVerified) {
          await user.sendEmailVerification();
          Get.snackbar(
            'Verification Email Sent',
            'Please check your email and verify your account.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }

        // Save full name to Firebase (optional)


        // Navigate to login or home after verification
        Get.toNamed(AppRoutes.login); // Or navigate to another screen

      } catch (e) {
        print(e.toString());
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.BOTTOM,
      );
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
              child: Column(
                children: [
                  // Background with curved design
                  Stack(
                    children: [
                      // Purple background
                      Container(
                        height: 280,
                        color: Colors.blue.shade800,
                      ),
                      // White curve
                      ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          height: 250,
                          color: Colors.white,
                        ),
                      ),
                      // Centered image on top of the curve
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/images/logo4.png', // Replace with your image path
                            height: 150,
                          ),
                        ),
                      ),
                      // "SignUp here" text on the purple background
                      Positioned(
                        top: 220, // Adjust this value to position the text on the purple curve
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'SignUp Here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24, // Adjust the font size as needed
                              fontWeight: FontWeight.bold, // Optional: Make the text bold
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Form fields
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          CustomTextField(
                            label: 'Confirm Password',
                            hint: 'Confirm your password',
                            isPassword: true,
                          ),
                          SizedBox(height: 30),
                          CustomButton(
                            text: 'Create New Account',
                            backgroundColor: Colors.blue.shade800,
                            onPressed: () {
                              _signUp();
                              // Handle sign-up action
                              // Get.toNamed(AppRoutes.home); // Navigate to home page
                            },
                          ),
                          SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              text: "Already a member? ",
                              children: [
                                TextSpan(
                                  text: "Log in now",
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.login); // Navigate to LoginScreen
                                    },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          Text(
                            'Or continue with',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialMediaButton(
                                icon: Icons.g_translate,
                                color: Colors.red,
                                onTap: () {},
                              ),
                              SizedBox(width: 20),
                              SocialMediaButton(
                                icon: Icons.apple,
                                color: Colors.black,
                                onTap: () {},
                              ),
                              SizedBox(width: 20),
                              SocialMediaButton(
                                icon: Icons.facebook,
                                color: Colors.blue,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
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
}
