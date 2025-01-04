import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../screens/home/UserDashboard.dart';
import '../utils/SharedPreferences.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs;
  void nextPage(PageController pageController, List<Map<String, String>> sliderData) {
    if (currentPage.value == sliderData.length - 1) {
      _onSkip();
    } else {
      pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
  void _onSkip() async {
    String? userdata = await getData();
    if (userdata == null || userdata.isEmpty) {
      Get.toNamed(AppRoutes.login);
    } else {
      Get.off(UserDashBoardScreen());
    }
  }

  void updatePage(int index) {
    currentPage.value = index;
  }
}
