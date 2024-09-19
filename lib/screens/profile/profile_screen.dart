import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class ProfileScreen extends StatelessWidget {
  final RxInt selectedIndex = 4.obs; // Initialize with the index for Profile

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
                height: screenHeight * 0.2, // Make height responsive
                color: Colors.blue.shade800,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.05, bottom: screenHeight * 0.01), // Responsive padding
                    child: Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.06), // Responsive font size
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -screenHeight * 0.08, // Responsive positioning
                child: CircleAvatar(
                  radius: screenWidth * 0.18, // Responsive radius
                  backgroundImage: AssetImage('assets/images/homeease_logo.png'),
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.1), // Responsive spacing
          Text(
            'Nayyer',
            style: TextStyle(fontSize: screenWidth * 0.055, fontWeight: FontWeight.bold, color: Colors.black), // Responsive font size
          ),
          Text(
            'nayyer123@gmail.com',
            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey), // Responsive font size
          ),
          SizedBox(height: screenHeight * 0.03), // Responsive spacing
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05), // Responsive padding
              children: [
                buildProfileOption(Icons.person, 'My Profile', () {
                  Get.toNamed(AppRoutes.profileEdit);
                }),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                buildProfileOption(Icons.support, 'Support', () {
                  Get.toNamed(AppRoutes.support); // Navigate to the Support page
                }),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                buildProfileOption(Icons.help, "FAQ'S", () {
                  Get.toNamed(AppRoutes.faq); // Navigate to the FAQ page
                }),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                buildProfileOption(Icons.share, 'Share App', () {}),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                buildProfileOption(Icons.exit_to_app, 'Sign out', () {
                  _showSignOutDialog(context);
                }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() => CustomBottomNavigationBar(
        currentIndex: selectedIndex.value,
        onTap: (index) {
          selectedIndex.value = index;
          switch (index) {
            case 0:
              Get.toNamed(AppRoutes.home);
              break;
            case 1:
              Get.toNamed(AppRoutes.myAds);
              break;
            case 2:
              Get.toNamed(AppRoutes.myCart);
              break;
            case 3:
              Get.toNamed(AppRoutes.chat);
              break;
            case 4:
              Get.toNamed(AppRoutes.profile);
              break;
          }
        },
      )),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.logout, size: 40, color: Colors.blueAccent), // Logout icon with color
                SizedBox(height: 20), // Spacing
                Text(
                  'Already leaving?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10), // Spacing
                Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20), // Spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _signOut();
                        Get.back();
                      },
                      child: Text('Yes, Logout'),
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


  void _signOut() {
    // Implement your sign-out logic here
    // Example: AuthService().signOut(); Get.offNamed(AppRoutes.login);
  }

  Widget buildProfileOption(IconData icon, String title, VoidCallback onClicked) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue.shade800, size: 24), // Responsive icon size
        title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onClicked,
      ),
    );
  }
}