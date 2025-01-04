import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/screens/home/UserDashboard.dart';
import 'package:shift_ease_fyp/utils/SharedPreferences.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import '../../Controllers/OnboardingController.dart';
import '../../routes/app_routes.dart';
import '../common/slider_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());
    final PageController pageController = PageController(initialPage: 0);

    final List<Map<String, String>> sliderData = [
      {"imagePath": "assets/images/slider1.jpg", "title": "Transform Your Space", "description": "Transform your space into a brand-new home with ease."},
      {"imagePath": "assets/images/slider2.png", "title": "Effortless Shifting", "description": "Move to your new home with ease and comfort."},
      {"imagePath": "assets/images/slider3.jpg", "title": "Seamless Relocation", "description": "Experience a smooth transition to your new home, stress-free."},
      {"imagePath": "assets/images/slider4.jpg", "title": "Stylish Interiors", "description": "Elevate your home's look with modern and chic design ideas."},
      {"imagePath": "assets/images/slider5.jpg", "title": "Transformative Design Tips", "description": "Learn how to refresh your space with simple and effective design techniques."},
    ];
    return Scaffold(
      backgroundColor:Colors.blue.shade300,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            onPageChanged: (index) {
              controller.updatePage(index);
            },
            itemCount: sliderData.length,
            itemBuilder: (context, index){
              return  SliderScreen(
                imagePath: sliderData[index]['imagePath']!,
                title: sliderData[index]['title']!,
                description: sliderData[index]['description']!,
              );
            }
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () async {
                String? userdata = await getData();
                if (userdata == null || userdata.isEmpty) {
                  Get.toNamed(AppRoutes.login);
                } else {
                  Get.off(UserDashBoardScreen());
                }
              },
              child: const CustomTextWidget(
               title:  "Skip",
                  color: Colors.white,
                  weight: FontWeight.bold,
                  size: 25,
              ),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  sliderData.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 10,
                    width: controller.currentPage.value == index ? 25 : 10,
                    decoration: BoxDecoration(
                      color: controller.currentPage.value == index ? Colors.yellow : Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              );
            }),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  controller.nextPage(pageController, sliderData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.black.withOpacity(0.3),
                  elevation: 10,
                ),
                child: Text(
                  controller.currentPage.value == sliderData.length - 1 ? 'Get Started' : 'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
