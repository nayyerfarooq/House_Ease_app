import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/routes/app_routes.dart';
import 'package:shift_ease_fyp/screens/ads/AdsAddingForms/ApartmentSellingScreen.dart';
import 'package:shift_ease_fyp/screens/ads/AdsAddingForms/HouseSellingScreen.dart';
import 'package:shift_ease_fyp/screens/ads/AdsAddingForms/OfficeSellingScreen.dart';
import 'package:shift_ease_fyp/screens/auth/ForgetPasswordScreen.dart';
import 'package:shift_ease_fyp/screens/auth/SignUpScreen.dart';
import 'package:shift_ease_fyp/screens/common/splash_screen.dart';
import 'package:shift_ease_fyp/screens/home/UserDashboard.dart';
import 'package:shift_ease_fyp/screens/mycart/my_cart_page.dart';
import 'package:shift_ease_fyp/screens/onboarding/onboarding_screen.dart';
import 'package:shift_ease_fyp/screens/auth/login_screen.dart';
import 'package:shift_ease_fyp/screens/ads/my_ads_page.dart';
import 'package:shift_ease_fyp/screens/chat/chat_screen.dart';
import 'package:shift_ease_fyp/screens/profile/faq_page.dart';
import 'package:shift_ease_fyp/screens/profile/profile_screen.dart';
import 'package:shift_ease_fyp/screens/profile/support_page.dart';
import 'package:shift_ease_fyp/firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
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
        GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
        GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.signup, page: () => SignUpScreen()),
        GetPage(name: AppRoutes.forgotPassword, page: () => ForgotPasswordScreen()),
        GetPage(name: AppRoutes.home, page: () => UserDashBoardScreen()),
        GetPage(name: AppRoutes.myAds, page: () => MyAdsPage()),
        GetPage(name: AppRoutes.myCart, page: () => MyCartPage()),
        GetPage(name: AppRoutes.chat, page: () => const ChatScreen()),
        GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
        GetPage(name: AppRoutes.support, page: () => const SupportPage()),
        GetPage(name: AppRoutes.faq, page: () => FAQPage()),
        GetPage(name: AppRoutes.houseSelling, page: () => HouseSellingScreen()),
        GetPage(name: AppRoutes.officeSelling, page: () => OfficeSellingScreen()),
        GetPage(name: AppRoutes.apartmentSelling, page: () => ApartmentSellingScreen()),

      ],
    );
  }
}