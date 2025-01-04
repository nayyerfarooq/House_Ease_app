import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Modals/RentAdFetchModal.dart';
import '../../../apiUrl.dart';
import '../../../widgets/CustomTextWidget.dart';

class PropertyDetailController extends GetxController {
  var showFullDescription = false.obs;
}
class PropertyDetailScreen extends StatelessWidget {
  final PropertyDetailController controller = Get.put(PropertyDetailController());
  final FetchRentAdModal property;
  PropertyDetailScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  '${ApiUrl.baseUrl}${property.images[0].image}',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextWidget(
                        title: property.title,
                        color: Colors.white,
                        size: 24,
                        weight: FontWeight.bold,

                      ),
                      const SizedBox(height: 5),
                      CustomTextWidget(
                        title: property.address,
                        color: Colors.white, size: 16,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.bed, color: Colors.white),
                          const SizedBox(width: 5),
                          CustomTextWidget(
                            title: property.bedrooms ?? '',
                            color: Colors.white,
                          ),
                          const SizedBox(width: 20),
                          const Icon(Icons.bathtub, color: Colors.white),
                          const SizedBox(width: 5),
                          CustomTextWidget(
                            title:  property.bathrooms ?? "",
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    title: 'Description', size: 18,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  Obx(() => CustomTextWidget(
                    title:  controller.showFullDescription.value
                        ? property.description
                        : property.description.substring(0,10),
                    size: 16, color: Colors.grey,
                  )),
                  GestureDetector(
                    onTap: () {
                      controller.showFullDescription.toggle();
                    },
                    child: CustomTextWidget(
                      title: controller.showFullDescription.value ? 'Show Less' : 'Show More',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('${ApiUrl.baseUrl}${property.images[0].image}'),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            title:  property.ownerName.toUpperCase(),
                            weight: FontWeight.bold,size: 16,
                          ),
                          const CustomTextWidget(
                            title:  'Owner', color: Colors.grey,
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.blue),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomTextWidget(
                    title:  'Gallery',
                    size: 18,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(4, (index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage('assets/images/Luxury_apart.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('Map Placeholder')),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        title: '${property.pricePerMonth} / Month',
                        size: 18,
                        weight: FontWeight.bold,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        ),
                        onPressed: () {},
                        child: const CustomTextWidget(
                            title:  'Rent Now',
                            size: 16,
                            color: Colors.white,
                        ),
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
