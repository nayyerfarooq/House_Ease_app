import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../../utils/custom_clipper.dart';
import '../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                  'Mail Address Here',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Enter the email address associated with your account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
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
                SizedBox(height: 30),
                CustomButton(
                  text: 'Recover Password', // Specify the button text
                  onPressed: () {
                    Get.toNamed(AppRoutes.emailVerification); // Define the action on button press
                  },
                  backgroundColor: Colors.blue.shade800, // Customize the background color
                  textColor: Colors.white, // Customize the text color
                  borderRadius: 10.0, // Customize the border radius
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
