import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/home/CompanyRelated/CompanyLogoWidget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../Apis/CompanyApi.dart';
import '../../../widgets/CustomTextWidget.dart';
import '../../../widgets/app_colors.dart';
import '../CompanyRelated/AllCompaniesScreen.dart';
import '../PackagesRelated/PackagesCards.dart';

class PackagesScreen extends StatefulWidget {
  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.page == 2) {
        _pageController.jumpToPage(0);
      } else {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
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
    final screenWidth = Get.width;
    final isSmallScreen = screenWidth < 600;

    final companies = List.generate(10, (index) => 'Company ${index + 1}');
    final CompanyController companyController = Get.put(CompanyController());
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
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
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 4,
                      effect: const WormEffect(
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
          const SizedBox(height: 15),
          Text(
            'House-Ease Offerings',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
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
          CustomTextWidget(
              title: 'Service Providers Companies',
              size: screenWidth * 0.045, weight: FontWeight.bold
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (companyController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (companyController.companies.isEmpty) {
              return const Center(child: Text('No companies available'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth < 600 ? 2 : 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: screenWidth < 600 ? 1 : 1.5,
                ),
                itemCount: companyController.companies.length > 4
                    ? 4
                    : companyController.companies.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final company = companyController.companies[index];
                  return CompanyLogoButton(
                    label: company.name,
                    logoPath: company.logoPath,
                    email: company.email,
                    address: company.address,
                    service: company.service,
                    Companyid: company.Companyid,
                    MobileNo: company.MobileNo,
                  );
                },
              );
            }
          }),
          if (companyController.companies.length > 4)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Get.to(AllCompaniesScreen(companies: companyController.companies));
                  },
                  child: CustomTextWidget(
                      title: 'View All Companies',
                      color: AppColors.primaryDarkColor, size: screenWidth * 0.035),
                ),
              ),
            ),
        ],
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
              CustomTextWidget(
                title:  title,
                color: Colors.white,
                size: 22,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 5),
              CustomTextWidget(
                title:  subtitle,
                color: Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ],
    );
  }
}