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
      child: SingleChildScrollView(
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
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              )
                  : Container(
                height: MediaQuery.of(context).size.height * 0.25,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    title: ad.title,
                    size: 18,
                    weight: FontWeight.bold,
                    color: Colors.black87,
                    lines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: Colors.green[700]),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'PKR ${ad.pricePerMonth} Per Month',
                        color: Colors.green[700],
                        size: 16,
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[600]),
                      const SizedBox(width: 6),
                      Expanded(
                        child: CustomTextWidget(
                          title: ad.address,
                          color: Colors.grey[600],
                          size: 14,
                          lines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.blueGrey[600]),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'Owner: ${ad.ownerName}',
                        size: 14,
                        color: Colors.blueGrey[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.home, color: Colors.teal[600]),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'Property Type: ${ad.propertyType}',
                        size: 14,
                        color: Colors.teal[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.bed, color: Colors.orange[600]),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'Bedrooms: ${ad.bedrooms}',
                        size: 14,
                        color: Colors.orange[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.bathtub, color: Colors.purple[600]),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'Bathrooms: ${ad.bathrooms}',
                        size: 14,
                        color: Colors.purple[600],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: ad.requestStatus == 'Pending'
                            ? Colors.orange
                            : Colors.green,
                      ),
                      const SizedBox(width: 6),
                      CustomTextWidget(
                        title: 'Status: ${ad.requestStatus}',
                        size: 14,
                        weight: FontWeight.bold,
                        color: ad.requestStatus == 'Pending'
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
