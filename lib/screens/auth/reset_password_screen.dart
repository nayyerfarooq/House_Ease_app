import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_clipper.dart';
import '../../widgets/custom_button.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
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
                  'Enter New Password',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Your new password must be different from previously used password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.blue.shade800),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    // Handle continue logic here
                  },
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
