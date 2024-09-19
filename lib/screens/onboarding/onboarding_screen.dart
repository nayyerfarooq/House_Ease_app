import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
import '../common/slider_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _sliderData = [
    {"imagePath": "assets/images/slider1.jpg", "title": "Transform Your Space", "description": "Transform your space into a brand-new home with ease."},
    {"imagePath": "assets/images/slider2.png", "title": "Effortless Shifting", "description": "Move to your new home with ease and comfort."},
    {"imagePath": "assets/images/slider3.jpg", "title": "Seamless Relocation", "description": "Experience a smooth transition to your new home, stress-free."},
    {"imagePath": "assets/images/slider4.jpg", "title": "Stylish Interiors", "description": "Elevate your home's look with modern and chic design ideas."},
    {"imagePath": "assets/images/slider5.jpg", "title": "Transformative Design Tips", "description": "Learn how to refresh your space with simple and effective design techniques."},
  ];

  void _onSkip() {
    Get.offNamed(AppRoutes.login);
  }

  void _onNext() {
    if (_currentPage == _sliderData.length - 1) {
      _onSkip();
    } else {
      _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _sliderData.length,
            itemBuilder: (context, index) => SliderScreen(
              imagePath: _sliderData[index]['imagePath']!,
              title: _sliderData[index]['title']!,
              description: _sliderData[index]['description']!,
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _onSkip,
              child: Text("Skip", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _sliderData.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
