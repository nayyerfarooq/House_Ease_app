import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/PackageBuyRequestApi.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class MyCartPage extends StatefulWidget {
  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  final PackageBuyController controller = Get.put(PackageBuyController());

  @override
  void initState() {
    super.initState();
    controller.getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          title: 'My Cart',
          size: 24,
          weight: FontWeight.bold,
          color: Colors.white,
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.CartItemData.isEmpty) {
          return const Center(
            child: Text(
              'No items in the cart',
              style: TextStyle(fontSize: 18),
            ),
          );
        } else {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.CartItemData.length,
            itemBuilder: (context, index) {
              var cartItem = controller.CartItemData[index];
              return Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextWidget(
                              title: 'Order #${cartItem.orderId}',
                              size: 20,
                              weight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          cartItem.orderStatus == 'Completed'?
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ):const CustomTextWidget(title: ''),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Divider(thickness: 1, color: Colors.grey[300]),
                      const SizedBox(height: 8),
                      CustomTextWidget(
                        title: 'Client: ${cartItem.clientName}',
                        size: 18,
                        color: Colors.grey[800],
                      ),
                      CustomTextWidget(
                        title: 'Location: ${cartItem.location}',
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      CustomTextWidget(
                        title: 'Service Date: ${cartItem.serviceDate}',
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextWidget(
                                title: 'Package ID: ${cartItem.packageId}',
                                size: 16,
                                color: Colors.blueAccent,
                                weight: FontWeight.w600,
                              ),
                              CustomTextWidget(
                                title: 'Price: ${cartItem.packagePrice}',
                                size: 18,
                                color: Colors.green[700],
                                weight: FontWeight.bold,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomTextWidget(
                                title: 'Team: ${cartItem.teamName}',
                                size: 16,
                                color: Colors.grey[700],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                  horizontal: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: cartItem.orderStatus == 'Processing'
                                      ? Colors.orangeAccent
                                      : cartItem.orderStatus == 'Completed'
                                          ? Colors.greenAccent
                                          : Colors.redAccent,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: CustomTextWidget(
                                  title: 'Status: ${cartItem.orderStatus}',
                                  size: 16,
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      }),
    );
  }
}
