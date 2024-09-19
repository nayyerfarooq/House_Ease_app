import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/custom_clipper.dart';
import '../../routes/app_routes.dart';

class EmailVerificationScreen extends StatelessWidget {
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
                  'Get Your Code',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Please enter the 4 digit code that\nwas sent to your email address.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOTPBox('5'),
                    _buildOTPBox('4'),
                    _buildOTPBox('8'),
                    _buildOTPBox('6'),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Handle resend code logic here
                  },
                  child: Text(
                    "If you don't receive code! Resend",
                    style: TextStyle(color: Colors.blue.shade800),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.resetPassword);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Verify and Proceed', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOTPBox(String digit) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: 40,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          digit,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
