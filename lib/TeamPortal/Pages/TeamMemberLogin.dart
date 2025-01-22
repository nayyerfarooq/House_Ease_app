import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/TeamPortal/TeamPortalApis/TeamLeaderLoginApi.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../../screens/auth/login_screen.dart';
import '../../widgets/CustomElevatedButton.dart';
import '../../widgets/custom_snakbar.dart';
import '../../widgets/custom_text_field.dart';

class TeamMemberLoginPage extends StatelessWidget {
  TeamMemberLoginPage({super.key});
  final TextEditingController _emailController = TextEditingController();
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
                  Color(0xFFffffff),
                  Color(0xFF2A2D4E),
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

                  // Obx(() {
                  //   return DropdownButtonFormField<String>(
                  //     value: teamCompanyController.selectedCompany.value.isEmpty
                  //         ? null
                  //         : teamCompanyController.selectedCompany.value,
                  //     items: teamCompanyController.companies.map((company) =>
                  //         DropdownMenuItem<String>(
                  //           value: company,
                  //           child: Text(
                  //             company,
                  //             style: TextStyle(fontSize: width * 0.04),
                  //           ),
                  //         ))
                  //         .toList(),
                  //     onChanged: (value) {
                  //       teamCompanyController.selectedCompany.value = value!;
                  //     },
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       hintText: 'Select Company',
                  //       hintStyle: TextStyle(color: Colors.grey.shade600),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(16),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //   );
                  // }),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    label: 'Email Address',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    prefixIcon: const Icon(FontAwesomeIcons.addressBook),
                    fillColor: Colors.white,
                    fillType: true,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomElevatedButton(
                    text: 'Login',
                    color: Colors.white,
                    padding: 12,
                    radius: 12,
                    backcolor: Colors.blue.shade700,
                    path: ()async {
                      try {
                          await teamLeaderLogin(email: _emailController.text, occupation: 'Leader');

                      }catch(e) {
                        showErrorSnackbar(e.toString());
                      }
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
}