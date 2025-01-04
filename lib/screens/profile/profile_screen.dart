import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/profile/profile_edit_screen.dart';
import 'package:shift_ease_fyp/utils/SharedPreferences.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import '../../routes/app_routes.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RxInt selectedIndex = 4.obs;
  bool isLoading = false;
  Map<String, dynamic>? userData;

  void FectingUserData() async{
    userData = await getUserData();
  }

  @override
  void initState(){
    super.initState();
    FectingUserData();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                height: screenHeight * 0.2,
                color: Colors.blue.shade800,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                        bottom: screenHeight * 0.01),
                    child: CustomTextWidget(
                      title: 'Profile',
                      color: Colors.white,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -screenHeight * 0.08,
                child: CircleAvatar(
                  radius: screenWidth * 0.18,
                  backgroundImage:
                      const AssetImage('assets/images/logo1.png'),
                      backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.1),
          CustomTextWidget(
              title: '${userData?['username']}',
              size: screenWidth * 0.055,
              weight: FontWeight.bold,
              color: Colors.black),
          CustomTextWidget(
              title:'${userData?['email']}',
              size: screenWidth * 0.04,
              color: Colors.grey),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              children: [
                buildProfileOption(Icons.person, 'My Profile', () {
                  Get.to(ProfileEditScreen(userData: userData));
                }),
                SizedBox(height: screenHeight * 0.01),
                buildProfileOption(Icons.support, 'Support', () {
                  Get.toNamed(AppRoutes.support);
                }),
                SizedBox(height: screenHeight * 0.01),
                buildProfileOption(Icons.help, "FAQ'S", () {
                  Get.toNamed(AppRoutes.faq);
                }),
                SizedBox(height: screenHeight * 0.01),
                buildProfileOption(Icons.share, 'Share App', () {}),
                SizedBox(height: screenHeight * 0.01),
                buildProfileOption(Icons.exit_to_app, 'Sign out', () {
                  _showSignOutDialog(context);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
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
                const SizedBox(height: 20), // Spacing
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
                isLoading == true
                    ? const CircularProgressIndicator()
                    : Row(
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
                              isLoading = true;
                              try {
                                await clearData();
                                await clearUserData();
                              } catch (e) {
                                showErrorSnackbar(e.toString());
                              } finally {
                                isLoading = false;
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

  Widget buildProfileOption(
      IconData icon, String title, VoidCallback onClicked) {
    return Card(
      elevation: 6,
      shadowColor: Colors.blue.shade200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          leading: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          title: CustomTextWidget(
            title: title,
            size: 18,
            weight: FontWeight.w600,
            color: Colors.white,
          ),
          trailing: const Icon(Icons.arrow_forward_ios,
              color: Colors.white70, size: 20),
          onTap: onClicked,
        ),
      ),
    );
  }
}
