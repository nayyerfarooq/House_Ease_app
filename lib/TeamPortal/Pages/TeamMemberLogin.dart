import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/Pages/teamMemberDashboard.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../../screens/auth/login_screen.dart';
import '../../widgets/CustomElevatedButton.dart';
import '../Controllers/CompanyFextingController.dart';

class TeamMemberLoginPage extends StatelessWidget {
  TeamMemberLoginPage({super.key});

  final TeamCompanyController teamCompanyController = Get.put(
      TeamCompanyController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double width = mediaQuery.size.width;
    final double height = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFffffff), // Light gradient color
                  Color(0xFF2A2D4E), // Dark gradient color
                ],
              ),
            ),
          ),
          // Foreground Content
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.08,
                vertical: height * 0.02,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: width * 0.15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.group,
                      size: width * 0.15,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: height * 0.03),

                  CustomTextWidget(
                    title: 'Login as Team Leader',
                    size: width * 0.06,
                    weight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                  SizedBox(height: height * 0.02),

                  Obx(() {
                    return DropdownButtonFormField<String>(
                      value: teamCompanyController.selectedCompany.value.isEmpty
                          ? null
                          : teamCompanyController.selectedCompany.value,
                      items: teamCompanyController.companies
                          .map((company) =>
                          DropdownMenuItem<String>(
                            value: company,
                            child: Text(
                              company,
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                          ))
                          .toList(),
                      onChanged: (value) {
                        teamCompanyController.selectedCompany.value = value!;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Select Company',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: height * 0.02),
                  buildInputField(
                    context,
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  SizedBox(height: height * 0.02),

                  buildInputField(
                    context,
                    hintText: 'Enter your password',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  SizedBox(height: height * 0.03),


                  CustomElevatedButton(
                    text: 'Login',
                    color: Colors.white,
                    padding: 12,
                    radius: 12,
                    backcolor: Colors.blue.shade700,
                    path: () {
                      Get.to(const TeamMemberDashboard());
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  TextButton(
                    onPressed: () {
                      Get.to(LoginScreen());
                    },
                    child: Text(
                      'Login as User',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.045,
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

  Widget buildInputField(BuildContext context,
      {required String hintText, required IconData icon, required bool obscureText}) {
    final RxBool isObscured = obscureText
        .obs;

    return Obx(() =>
        TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
            prefixIcon: Icon(
              icon,
              color: Colors.blue.shade600,
              size: 24,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                isObscured.value = !isObscured.value; // Toggle visibility
              },
              icon: Icon(
                isObscured.value ? Icons.visibility_off : Icons.visibility,
                color: Colors.blue.shade600,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.blue.shade800, width: 2.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
                vertical: 16.0, horizontal: 12.0),
          ),
          obscureText: isObscured.value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ));
  }
}