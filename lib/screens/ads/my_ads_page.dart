import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart'; // Ensure you have this import
import '../../widgets/app_colors.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class MyAdsPage extends StatelessWidget {
  final RxInt selectedIndex = 1.obs; // Initialize with the index for My Ads

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: Text('My Ads', style: TextStyle( color:AppColors.accentColor)),
          automaticallyImplyLeading: false, // This removes the back arrow
          actions: [
            TextButton.icon(
              onPressed: () {
                _showBottomSheet(context); // Call the function to open the bottom sheet
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text("Add your ad", style: TextStyle(color:AppColors.accentColor)),
            ),
          ],
        ),
        body: LayoutBuilder( // Use LayoutBuilder for responsiveness
          builder: (context, constraints) {
            // Get the screen size
            double screenWidth = MediaQuery.of(context).size.width;

            return Column(
              children: [
                TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16, // Adjust font size based on screen width
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: screenWidth < 600 ? 13 : 15, // Adjust font size for unselected tabs
                  ),
                  tabs: [
                    Tab(text: 'Active (0)'),
                    Tab(text: 'Pending (0)'),
                    Tab(text: 'Removed (0)'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      NoAdsWidget(message: 'No Active Ads', isSmallScreen: screenWidth < 600),
                      NoAdsWidget(message: 'No Pending Ads', isSmallScreen: screenWidth < 600),
                      NoAdsWidget(message: 'No Removed Ads', isSmallScreen: screenWidth < 600),
                    ],
                  ),
                ),
              ],
            );
          },
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
      ),
    );
  }

  // Function to show the bottom sheet
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Increase the size of the bottom sheet
            children: [
              // Close button at the top-right corner
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back(); // Close the bottom sheet
                    },
                    child: Icon(Icons.close, size: 24, color: Colors.black), // Cross icon
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'What do you want to sell?',
                style: TextStyle(
                  fontSize: screenWidth < 600 ? 16 : 18, // Adjust font size
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(context, Icons.home, 'House', screenWidth < 600),
                  _buildOption(context, Icons.business, 'Office', screenWidth < 600),
                  _buildOption(context, Icons.apartment, 'Apartment', screenWidth < 600),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget to build each option
// Widget to build each option
  Widget _buildOption(BuildContext context, IconData icon, String label, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the bottom sheet after selection
        switch (label) {
          case 'House':
            Get.toNamed(AppRoutes.houseSelling); // Navigate to House Selling Screen
            break;
          case 'Office':
            Get.toNamed(AppRoutes.officeSelling); // Navigate to Office Selling Screen
            break;
          case 'Apartment':
            Get.toNamed(AppRoutes.apartmentSelling); // Navigate to Apartment Selling Screen
            break;
        }
      },
      child: Column(
        children: [
          Icon(icon, size: isSmallScreen ? 30 : 40, color: Colors.black), // Adjust icon size
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16, // Adjust text size
            ),
          ),
        ],
      ),
    );
  }

}

class NoAdsWidget extends StatelessWidget {
  final String message;
  final bool isSmallScreen;

  NoAdsWidget({required this.message, required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: isSmallScreen ? 80 : 100, color: Colors.grey), // Adjust icon size
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: isSmallScreen ? 16 : 18, // Adjust text size
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "You haven't posted anything yet. Would you like to sell something?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16, // Adjust text size
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
