import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/routes/app_routes.dart';
import 'package:shift_ease_fyp/screens/ads/ApartmentSellingScreen.dart';
import 'package:shift_ease_fyp/screens/ads/HouseSellingScreen.dart';
import 'package:shift_ease_fyp/screens/ads/OfficeSellingScreen.dart';
import 'package:shift_ease_fyp/screens/auth/ForgetPasswordScreen.dart';
import 'package:shift_ease_fyp/screens/auth/SignUpScreen.dart';
import 'package:shift_ease_fyp/screens/common/splash_screen.dart';
import 'package:shift_ease_fyp/screens/home/all_in_one_packages_page.dart';
import 'package:shift_ease_fyp/screens/home/decorate_house_page.dart';
import 'package:shift_ease_fyp/screens/home/shift_house_page.dart';
import 'package:shift_ease_fyp/screens/mycart/my_cart_page.dart';
import 'package:shift_ease_fyp/screens/onboarding/onboarding_screen.dart';
import 'package:shift_ease_fyp/screens/auth/login_screen.dart';
import 'package:shift_ease_fyp/screens/auth/email_verification_screen.dart';
import 'package:shift_ease_fyp/screens/auth/reset_password_screen.dart';
import 'package:shift_ease_fyp/screens/home/home_screen.dart';
import 'package:shift_ease_fyp/screens/ads/my_ads_page.dart';
import 'package:shift_ease_fyp/screens/chat/chat_screen.dart';
import 'package:shift_ease_fyp/screens/profile/faq_page.dart';
import 'package:shift_ease_fyp/screens/profile/profile_screen.dart';
import 'package:shift_ease_fyp/screens/profile/profile_edit_screen.dart';
import 'package:shift_ease_fyp/screens/profile/support_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HouseEase',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: [
        GetPage(name: AppRoutes.splash, page: () => SplashScreen()),
        GetPage(name: AppRoutes.onboarding, page: () => OnboardingScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.signup, page: () => SignUpScreen()),
        GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
        GetPage(name: AppRoutes.emailVerification, page: () => EmailVerificationScreen()),
        GetPage(name: AppRoutes.resetPassword, page: () => ResetPasswordScreen()),
        GetPage(name: AppRoutes.home, page: () => HomeScreen()),
        GetPage(name: AppRoutes.myAds, page: () => MyAdsPage()),
        GetPage(name: AppRoutes.myCart, page: () => MyCartPage()),
        GetPage(name: AppRoutes.chat, page: () => ChatScreen()),
        GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
        GetPage(name: AppRoutes.profileEdit, page: () => ProfileEditScreen()),
        GetPage(name: AppRoutes.support, page: () => SupportPage()),
        GetPage(name: AppRoutes.faq, page: () => FAQPage()),
        GetPage(name: AppRoutes.shiftHouse, page: () => ShiftHousePage()),
        GetPage(name: AppRoutes.decorateHouse, page: () => DecorateHousePage()),
        GetPage(name: AppRoutes.allInOnePackages, page: () => AllInOnePackagesPage()),
        GetPage(name: AppRoutes.houseSelling, page: () => HouseSellingScreen()),
        GetPage(name: AppRoutes.officeSelling, page: () => OfficeSellingScreen()),
        GetPage(name: AppRoutes.apartmentSelling, page: () => ApartmentSellingScreen()),

      ],
    );
  }
}