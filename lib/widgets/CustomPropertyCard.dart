import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';
import '../Modals/RentAdFetchModal.dart';
import '../apiUrl.dart';
import '../screens/home/RentAdsRelated/RentAdsDetailsScreen.dart';
import 'CustomTextWidget.dart';

class Custompropertycard  extends StatelessWidget {
  final FetchRentAdModal property;
  const Custompropertycard({super.key,required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Property Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              '${ApiUrl.baseUrl}${property.images[0].image}',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  title: property.propertyType,
                  size: 20, weight: FontWeight.bold,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                    const SizedBox(width: 4),
                    CustomTextWidget(title: property.address, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextWidget(title: property.pricePerMonth, color: Colors.green, weight: FontWeight.bold),
                    CustomTextWidget(title: "${property.area ?? ''} /SqFeet", color: Colors.black54),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.bed, color: Colors.blueAccent, size: 20),
                        const SizedBox(width: 4),
                        CustomTextWidget(title: '${property.bedrooms} Bedrooms', color: Colors.black87),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.bathtub, color: Colors.blueAccent, size: 20),
                        const SizedBox(width: 4),
                        CustomTextWidget(title: '${property.bathrooms} Bathrooms', color: Colors.black87),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(PropertyDetailScreen(property: property));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:AppColors.primaryDarkColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const CustomTextWidget(
                      title:  'View Details',
                      color: Colors.white, weight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );;
  }
}
