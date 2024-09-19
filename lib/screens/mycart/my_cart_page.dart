import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';

class MyCartPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('My Cart'),
            ),
            body: Center(
                child: Text('This is the My Cart page'),
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: 2,
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
            ) ,// Add the custom bottom navigation bar
        );
    }
}
