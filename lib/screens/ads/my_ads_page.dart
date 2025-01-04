import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/ads/adsPagesComponents/ActiveAdPage.dart';
import 'package:shift_ease_fyp/screens/ads/adsPagesComponents/PendingAdPage.dart';
import 'package:shift_ease_fyp/screens/ads/adsPagesComponents/RemovedAdPage.dart';
import '../../routes/app_routes.dart';
import '../../widgets/CustomTextWidget.dart';
import '../../widgets/app_colors.dart';

class MyAdsPage extends StatelessWidget {
  final RxInt selectedIndex = 1.obs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade800,
          title: const Text('My Ads', style: TextStyle( color:AppColors.accentColor)),
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: const Icon(Icons.add, color: Colors.white),
              label: const CustomTextWidget(title:"Add your ad", color:AppColors.accentColor),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = MediaQuery.of(context).size.width;

            return Column(
              children: [
                TabBar(
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: screenWidth < 600 ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: screenWidth < 600 ? 13 : 15,
                  ),
                  tabs: const [
                    Tab(text: 'Active'),
                    Tab(text: 'Pending'),
                    Tab(text: 'Removed'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                           ActiveAdsPage(),
                           PendingAdsPage(),
                           RemovedAdsPage(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(FontAwesomeIcons.rectangleXmark, size: 24, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              CustomTextWidget(
               title:  'What do you want to sell?',
                size: screenWidth < 600 ? 16 : 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(context, FontAwesomeIcons.house, 'House', screenWidth < 600),
                  _buildOption(context, FontAwesomeIcons.businessTime, 'Office', screenWidth < 600),
                  _buildOption(context, FontAwesomeIcons.building, 'Apartment', screenWidth < 600),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildOption(BuildContext context, IconData icon, String label, bool isSmallScreen) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        switch (label) {
          case 'House':
            Get.toNamed(AppRoutes.houseSelling);
            break;
          case 'Office':
            Get.toNamed(AppRoutes.officeSelling);
            break;
          case 'Apartment':
            Get.toNamed(AppRoutes.apartmentSelling);
            break;
        }
      },
      child: Column(
        children: [
          Icon(icon, size: isSmallScreen ? 30 : 40, color: Colors.black),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
        ],
      ),
    );
  }

}
