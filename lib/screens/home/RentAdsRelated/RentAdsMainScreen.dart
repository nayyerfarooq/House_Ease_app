import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/widgets/CustomPropertyCard.dart';
import 'package:shift_ease_fyp/widgets/custom_text_field.dart';
import '../../../Apis/FetchingAdsData.dart';

class RentAdsMainScreen extends StatefulWidget {
  RentAdsMainScreen({super.key});
  @override
  State<RentAdsMainScreen> createState() => _RentAdsMainScreenState();
}

class _RentAdsMainScreenState extends State<RentAdsMainScreen> {
  final FetchingAdsData controller = Get.put(FetchingAdsData());

  @override
  void initState() {
    super.initState();
    controller.fetchAdsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: CustomTextField(
              label: 'Search',
              hint: 'Search Properties',
            ),
          ),
        ),
      ),
      body: Obx((){
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.pendingAds.isEmpty) {
          return const Center(
            child: Text(
              'No Active Ads Found',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          );
        } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: controller.pendingAds.length,
                itemBuilder: (context, index) {
                  final property = controller.pendingAds[index];
                  return Custompropertycard(property: property);
                },
              ),
            );
          }
      })
    );
  }
}