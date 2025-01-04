import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/PackageApi.dart';
import 'package:shift_ease_fyp/Modals/ShiftingPackagesModal.dart';
import 'package:shift_ease_fyp/screens/home/PackagesRelated/packagesDetails.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class ShiftHousePackagesPage extends StatefulWidget {
  final String pack;
  const ShiftHousePackagesPage({super.key, required this.pack});

  @override
  State<ShiftHousePackagesPage> createState() => _ShiftHousePackagesPageState();
}

class _ShiftHousePackagesPageState extends State<ShiftHousePackagesPage> {
  final ShiftHouseController controller = Get.put(ShiftHouseController());
  @override
  void initState() {
    super.initState();
    controller.fetchPackages();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'House Services',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
      ),
      body:Obx(() {
      if (widget.pack == 'shift' && controller.shiftingPackages.isNotEmpty) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.shiftingPackages.isEmpty) {
          return const Center(child: Text('No Package available.'));
        } else {
          return ListView.builder(
            itemCount: controller.shiftingPackages.length,
            itemBuilder: (context, index) {
                return ShiftingPackagesCard(packages: controller.shiftingPackages[index]);
            },
          );
        }
      }
      else if (widget.pack == 'decorate'&& controller.decoratingPackages.isNotEmpty) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.decoratingPackages.isEmpty) {
          return const Center(child: Text('No Package available.'));
        } else {
          return ListView.builder(
            itemCount: controller.decoratingPackages.length,
            itemBuilder: (context, index) {
              return ShiftingPackagesCard(packages: controller.decoratingPackages[index]);
            },
          );
        }
      }
      else if (widget.pack == 'allinOne'&& controller.AllinOnePackages.isNotEmpty) {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else if (controller.AllinOnePackages.isEmpty) {
          return const Center(child: Text('No Package available.'));
        } else {
          return ListView.builder(
            itemCount: controller.AllinOnePackages.length,
            itemBuilder: (context, index) {
              return ShiftingPackagesCard(packages: controller.AllinOnePackages[index]);
            },
          );
        }
      }
      else {
        return const Center(child: CustomTextWidget(title: 'No valid package type found.'));
      }
      }),
    );
  }
}

class ShiftingPackagesCard extends StatelessWidget {
  final ShiftingPackagesModal packages;

  const ShiftingPackagesCard({super.key, required this.packages});

  @override
  Widget build(BuildContext context) {
    final screenWidth =Get.width;
    return GestureDetector(
      onTap: () {
        Get.to(PackageDetailsPage(
            title: packages.name,
            id: packages.id,
            image: packages.imagePath,
            price: packages.price,
            company: packages.company,
        ));
      },
      child: Card(
        elevation: 8,  // Increase elevation for depth
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenWidth * 0.02,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),  // Rounded corners
        ),
        child: Container(
          padding: const EdgeInsets.all(16),  // Padding inside the card
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [Colors.blue.shade900, Colors.blue.shade600],  // Gradient background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon with the package ID
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
                  Icons.local_shipping,  // Change to an icon representing the package
                  size: screenWidth * 0.08,
                  color: Colors.blue.shade800,
                ),
              ),
              const SizedBox(width: 20),  // Space between icon and text
              // Package Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidget(
                      title:packages.name,
                        weight: FontWeight.bold,
                        size: screenWidth * 0.045,
                        color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    CustomTextWidget(
                      title: 'Service: ${packages.service}',
                      size: screenWidth * 0.035,
                        color: Colors.white70,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              CustomTextWidget(
               title:  '\$${packages.price}',
                  weight: FontWeight.bold,
                  size: screenWidth * 0.05,
                  color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

