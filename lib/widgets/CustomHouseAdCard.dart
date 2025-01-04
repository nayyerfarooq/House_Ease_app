import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/Modals/RentAdFetchModal.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class CustomHouseAdCard extends StatelessWidget {
  final FetchRentAdModal ad;

  CustomHouseAdCard({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: ad.images.isNotEmpty
                ? Image.network(
              '${ApiUrl.baseUrl}${ad.images[0].image}',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            )
                : Container(
              height: 180,
              color: Colors.grey[300],
              child: const Center(
                child: CustomTextWidget(
                  title: 'No Image',
                    color: Colors.white,
                    size: 16,
                    weight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Card content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                 title:  ad.title,
                  size: 18,
                  weight: FontWeight.bold,
                  color: Colors.black87,
                  lines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  title: 'PKR ${ad.pricePerMonth}',
                    color: Colors.green[700],
                    size: 16,
                    weight: FontWeight.w500,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  title:ad.address,
                    color: Colors.grey[600],
                    size: 14,
                    lines: 1,
                     overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  title: 'Owner: ${ad.ownerName}',
                    size: 14,
                    color: Colors.blueGrey[600],
                  ),
                const SizedBox(height: 8),
                CustomTextWidget(
                  title: 'Status: ${ad.requestStatus}',
                  size: 14,
                  weight: FontWeight.bold,
                    color: ad.requestStatus == 'Pending'
                        ? Colors.orange
                        : Colors.green,
                ),
                const SizedBox(height: 12),
                // View Details Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
