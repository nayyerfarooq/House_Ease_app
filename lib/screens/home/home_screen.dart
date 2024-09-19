import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async'; // To implement auto-sliding
import '../../main.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_colors.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == 2) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.primaryDarkColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'HouseEase',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: isSmallScreen ? 20 : 24),
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          elevation: 4,
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
              fontSize: screenWidth < 600 ? 14 : 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: screenWidth < 600 ? 13 : 15,
            ),
            tabs: [
              Tab(text: 'Companies'),
              Tab(text: 'Rent House'),
              Tab(text: 'add'),
            ],
          ),
        ),
        body: Column(
          children: [
            NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: Stack(
                children: [
                  Container(
                    height: isSmallScreen ? 200 : 250,
                    child: PageView(
                      controller: _pageController,
                      children: [
                        _buildImageSliderItem(
                          'assets/images/Luxury_apart.jpg',
                          'Luxury Apartments',
                          'Find the best apartments in the city',
                        ),
                        _buildImageSliderItem(
                          'assets/images/specious_houses.jpg',
                          'Spacious Houses',
                          'Discover homes that match your lifestyle',
                        ),
                        _buildImageSliderItem(
                          'assets/images/modern_offices.jpg',
                          'Modern Offices',
                          'Upgrade your workspace in prime locations',
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          activeDotColor: AppColors.primaryDarkColor,
                          dotColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CategoryScreen(),
                  HouseRentScreen(),
                  Center(child: Text('Add tab if you want to add')),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
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
        ),
      ),
    );
  }

  Widget _buildImageSliderItem(String imagePath, String title, String subtitle) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.black.withOpacity(0.2),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final companies = List.generate(10, (index) => 'Company ${index + 1}');

    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Providers Companies',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: screenWidth < 600 ? 2 : 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: screenWidth < 600 ? 1 : 1.5,
            ),
            itemCount: companies.length > 4 ? 4 : companies.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CategoryWithLogoButton(
                label: companies[index],
                logoPath: 'assets/images/logo4.png',
              );
            },
          ),
          if (companies.length > 4)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.to(AllCompaniesScreen(companies: companies));
                  },
                  child: Text(
                    'View All Companies',
                    style: TextStyle(color: AppColors.primaryDarkColor, fontSize: screenWidth * 0.035),
                  ),
                ),
              ),
            ),
          SizedBox(height: 15),
          Text(
            'House-Ease Offerings',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              HouseEaseOfferingCard(
                title: 'Shift a House',
                icon: Icons.local_shipping,
              ),
              HouseEaseOfferingCard(
                title: 'Decorate a House',
                icon: Icons.brush,
              ),
              HouseEaseOfferingCard(
                title: 'All-in-One Packages',
                icon: Icons.all_inclusive,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HouseRentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for houses...',
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                ),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(child: CategoryIcon(label: 'Houses', icon: Icons.home)),
                    Flexible(child: CategoryIcon(label: 'Apartment', icon: Icons.apartment)),
                    Flexible(child: CategoryIcon(label: 'Offices', icon: Icons.business_center)),
                  ],
                );
              },
            ),
            SizedBox(height: 20),
            Text(
              'Houses for Rent',
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: screenWidth < 600 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: screenWidth < 600 ? 1.5 : 2,
              ),
              itemCount: 4,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return DestinationCard(
                  title: 'Lake Braies',
                  imagePath: 'assets/images/houserent.jpg',
                  location: 'Northern Italy',
                  rating: '5.0',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AllCompaniesScreen extends StatelessWidget {
  final List<String> companies;

  AllCompaniesScreen({required this.companies});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryDarkColor,
        centerTitle: true,
        title: Text('All Companies', style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045)),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenWidth < 600 ? 2 : 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: companies.length,
        itemBuilder: (context, index) {
          return CategoryWithLogoButton(
            label: companies[index],
            logoPath: 'assets/images/logo4.png',
          );
        },
      ),
    );
  }
}

class CategoryWithLogoButton extends StatelessWidget {
  final String label;
  final String logoPath;

  CategoryWithLogoButton({required this.label, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(logoPath, height: screenWidth * 0.1),
          SizedBox(height: 10),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: screenWidth * 0.03)),
        ],
      ),
    );
  }
}

class HouseEaseOfferingCard extends StatelessWidget {
  final String title;
  final IconData icon;

  HouseEaseOfferingCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: Icon(icon, size: screenWidth * 0.1, color: Colors.blue.shade800),
        title: Text(title, style: TextStyle(fontSize: screenWidth * 0.04)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: screenWidth * 0.04),
        onTap: () {
          if (title == 'Shift a House') {
            Get.toNamed(AppRoutes.shiftHouse);
          } else if (title == 'Decorate a House') {
            Get.toNamed(AppRoutes.decorateHouse);
          } else if (title == 'All-in-One Packages') {
            Get.toNamed(AppRoutes.allInOnePackages);
          }
        },
      ),
    );
  }
}

class CategoryIcon extends StatelessWidget {
  final String label;
  final IconData icon;

  CategoryIcon({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Flexible(
      child: Column(
        children: [
          Icon(icon, size: screenWidth * 0.1, color: Colors.blue.shade800),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: screenWidth * 0.03)),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String location;
  final String rating;

  DestinationCard({
    required this.title,
    required this.imagePath,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imagePath,
              height: screenWidth * 0.3,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04)),
                Text(location, style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03)),
                Row(
                  children: [
                    Icon(Icons.star, size: screenWidth * 0.04, color: Colors.amber),
                    SizedBox(width: 4),
                    Text(rating, style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.03)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
