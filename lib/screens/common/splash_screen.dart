import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    bool hasCompletedOnboarding = await _checkIfOnboardingIsComplete();
    bool isLoggedIn = await _checkIfUserIsLoggedIn();

    if (!hasCompletedOnboarding) {
      Get.offNamed(AppRoutes.onboarding);
    } else if (!isLoggedIn) {
      Get.offNamed(AppRoutes.login);
    } else {
      Get.offNamed(AppRoutes.home);
    }
  }

  Future<bool> _checkIfOnboardingIsComplete() async {
    return false;
  }

  Future<bool> _checkIfUserIsLoggedIn() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/applogo.png', width: 350),
      ),
    );
  }
}
