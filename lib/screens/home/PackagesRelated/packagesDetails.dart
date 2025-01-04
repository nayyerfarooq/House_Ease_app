import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/PackageBuyRequestApi.dart';
import 'package:shift_ease_fyp/apiUrl.dart';
import 'package:shift_ease_fyp/widgets/CustomElevatedButton.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/app_colors.dart';

class PackageDetailsPage extends StatelessWidget {
  final PackageBuyController controller = Get.put(PackageBuyController());
   final String title;
   final int id;
   final int price;
   final String image;
   final int company;
   PackageDetailsPage({super.key,
     required this.title,
     required this.id,
     required this.image,
     required this.price,
     required this.company,
   });
  final Map<String, dynamic> package = {
    'description': 'The premium package includes all features and priority support. '
        'It is designed for those who require top-tier service with a personalized experience. '
        'You get everything from essential features to advanced functionality.',
  };
  @override
  Widget build(BuildContext context) {
    final double screenHeight = Get.height;
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // SliverAppBar for collapsing effect
              SliverAppBar(
                expandedHeight: screenHeight * 0.4,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: CustomTextWidget(
                    title:title,
                      color: Colors.white,
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        '${ApiUrl.baseUrl}$image',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 100);
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Package details content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Package Title with Icon
                      Row(
                        children: [
                          Icon(Icons.card_giftcard, color: Colors.blueAccent, size: 30),
                          SizedBox(width: 8),
                          CustomTextWidget(
                            title:title,
                            size: 20,
                              weight: FontWeight.bold,
                              color: Colors.blueAccent.shade700,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),

                      // Package ID with Icon
                      Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blueAccent, size: 25),
                          SizedBox(width: 8),
                          CustomTextWidget(
                           title:  'Package ID: ${id}',
                            size: 16,
                              color: Colors.grey[600],
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.description_outlined, color: Colors.blueAccent, size: 25),
                          SizedBox(width: 8),
                          Expanded(
                            child: CustomTextWidget(
                            title:   package['description']!,
                              size: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.money, color: Colors.green, size: 30),
                          SizedBox(width: 8),
                          CustomTextWidget(
                           title:  price.toString(),
                            size: 24,
                              weight: FontWeight.bold,
                              color: Colors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 80),  // To create space for the bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Positioned "Buy Now" button at the bottom of the screen
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child:CustomElevatedButton(
                text: 'Buy Now',
                color: Colors.white,
                padding: 10,
                width: Get.width,
                radius: 10,
                backcolor: AppColors.primaryDarkColor,
                path: (){
                 _openBottomSheet(context);
                }
            ),
          ),
        ],
      ),
    );
  }
   void _openBottomSheet(BuildContext context) {
     Get.bottomSheet(
       GetBuilder<PackageBuyController>(
         builder: (_) {
           return Container(
             padding: EdgeInsets.only(
               bottom: MediaQuery.of(context).viewInsets.bottom,
               left: 20,
               right: 20,
               top: 20,
             ),
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
             ),
             child: SingleChildScrollView(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   // Bottom Sheet Title
                   const CustomTextWidget(
                     title: 'Service Details',
                     size: 24,
                       weight: FontWeight.bold,
                       color: Colors.blueAccent,
                   ),
                   const SizedBox(height: 20),
                   TextFormField(
                     controller: _.clientNameController,
                     decoration: InputDecoration(
                       labelText: 'Client Name',
                       prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12.0),
                       ),
                     ),
                   ),
                   SizedBox(height: 20),
                   TextFormField(
                     controller: _.locationController,
                     decoration: InputDecoration(
                       labelText: 'Location',
                       prefixIcon: const Icon(Icons.location_on, color: Colors.blueAccent),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12.0),
                       ),
                     ),
                   ),
                   const SizedBox(height: 20),
                   TextFormField(
                     controller: _.dateController,
                     readOnly: true,
                     decoration: InputDecoration(
                       labelText: 'Service Date',
                       prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueAccent),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(12.0),
                       ),
                     ),
                     onTap: () => _.selectDate(context),
                   ),
                   const SizedBox(height: 30),
                   CustomElevatedButton(
                       text: 'Book Service',
                       color: Colors.white,
                       backcolor: AppColors.primaryDarkColor,
                       padding: 10,
                       width: Get.width*0.6,
                       radius: 8,
                       path: (){
                            _.sendDataToApi(title,id,price,company);
                       }
                   ),
                   const SizedBox(height: 20),
                 ],
               ),
             ),
           );
         },
       ),
     );
   }
}
