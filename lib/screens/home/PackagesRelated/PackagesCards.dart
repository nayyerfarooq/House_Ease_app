import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Apis/PackageApi.dart';
import '../../../widgets/CustomTextWidget.dart';
import 'Packages.dart';

class HouseEaseOfferingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final ShiftHouseController controller = Get.put(ShiftHouseController());
  HouseEaseOfferingCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;

    return GestureDetector(
      onTap: () {
        if (title == 'Shift a House') {
          Get.to(const ShiftHousePackagesPage(pack: 'shift'));
        } else if (title == 'Decorate a House') {
          Get.to(const ShiftHousePackagesPage(pack: 'decorate'));
        } else if (title == 'All-in-One Packages') {
          Get.to(const ShiftHousePackagesPage(pack: 'allinOne'));
        }
      },
      child: Card(
        elevation: 8,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    size: screenWidth * 0.08,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        title:  title,
                        size: screenWidth * 0.045,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(height: 5),
                      CustomTextWidget(
                        title: 'Explore Now',
                        size: screenWidth * 0.035,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
                // Forward arrow
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white70,
                  size: screenWidth * 0.045,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}