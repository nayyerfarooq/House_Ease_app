import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/home/RentAdsRelated/RentAdsMainScreen.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../../widgets/app_colors.dart';
import 'HomeScreenRelated/TabOneScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    final isSmallScreen = screenWidth < 600;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryDarkColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                  title:  'HouseEase',
                  color: Colors.white, weight: FontWeight.bold, size: isSmallScreen ? 20 : 24),
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          elevation: 4,
          bottom: TabBar(
            indicatorColor: Colors.white,
              labelColor : const Color(0x96FC9BFF),
              unselectedLabelColor: Colors.white,
              labelStyle: TextStyle(
              fontSize: screenWidth < 600 ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: screenWidth < 600 ? 13 : 15,
            ),
            tabs: const [
              Tab(text: 'Companies'),
              Tab(text: 'Rent Ads'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PackagesScreen(),
            RentAdsMainScreen(),
          ],
        ),
        ),
    );
  }
}



