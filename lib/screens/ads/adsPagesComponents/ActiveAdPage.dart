import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/FetchingAdsData.dart';
import 'package:shift_ease_fyp/widgets/CustomHouseAdCard.dart';

class ActiveAdsPage extends StatefulWidget {
  @override
  State<ActiveAdsPage> createState() => _ActiveAdsPageState();
}

class _ActiveAdsPageState extends State<ActiveAdsPage> {
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
        } else if (controller.activeAds.isEmpty) {
          return const Center(
            child: Text(
              'No Active Ads Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: controller.activeAds.length,
              itemBuilder: (context, index) {
                var ad = controller.activeAds[index];
                return CustomHouseAdCard(ad: ad);
              },
            ),
          );
        }
      }),
    );
  }
}
