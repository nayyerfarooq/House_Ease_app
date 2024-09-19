import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
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
    await Future.delayed(Duration(seconds: 3), () {});

    // Check if the user has completed onboarding
    bool hasCompletedOnboarding = await _checkIfOnboardingIsComplete();
    bool isLoggedIn = await _checkIfUserIsLoggedIn();

    if (!hasCompletedOnboarding) {
      Get.offNamed(AppRoutes.onboarding);
    } else if (!isLoggedIn) {
      Get.offNamed(AppRoutes.login);
    } else {
      Get.offNamed(AppRoutes.home); // Navigate to Home if logged in and onboarding is complete
    }
  }

  Future<bool> _checkIfOnboardingIsComplete() async {
    // Replace with your logic to check if onboarding is complete
    // For example, read from shared preferences or a local database
    return false;
  }

  Future<bool> _checkIfUserIsLoggedIn() async {
    // Replace with your logic to check if the user is logged in
    // For example, check for a saved authentication token
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset('assets/images/homeease_logo.png', width: 350),
      ),
    );
  }
}
