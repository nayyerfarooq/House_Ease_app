import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/FetchingAdsData.dart';
import 'package:shift_ease_fyp/widgets/CustomHouseAdCard.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class PendingAdsPage extends StatefulWidget {
  @override
  State<PendingAdsPage> createState() => _PendingAdsPageState();
}

class _PendingAdsPageState extends State<PendingAdsPage> {
  final FetchingAdsData controller = Get.put(FetchingAdsData());
  @override
  void initState() {
    super.initState();
    controller.fetchAdsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.pendingAds.isEmpty) {
          return const Center(
            child: CustomTextWidget(
              title: 'No Active Ads Found',
              size: 18, weight: FontWeight.w500,
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: controller.pendingAds.length,
              itemBuilder: (context, index) {
                var ad = controller.pendingAds[index];
                return CustomHouseAdCard(ad: ad);
              },
            ),
          );
        }
      }),
    );
  }
}

