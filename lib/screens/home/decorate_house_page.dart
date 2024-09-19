import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package

class DecorateHousePage extends StatelessWidget {
  final List<DecorItem> decorItems = [
    DecorItem(
      name: 'Modern Sofa',
      description: 'A comfortable modern sofa.',
      price: 299,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    DecorItem(
      name: 'Vintage Lamp',
      description: 'An elegant vintage lamp.',
      price: 79,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    DecorItem(
      name: 'Wall Art',
      description: 'Abstract wall art.',
      price: 120,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    DecorItem(
      name: 'Indoor Plant',
      description: 'A beautiful indoor plant.',
      price: 35,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    DecorItem(
      name: 'Rug',
      description: 'A cozy rug for the living room.',
      price: 200,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    DecorItem(
      name: 'Rug',
      description: 'A cozy rug for the living room.',
      price: 200,
      imageUrl: 'https://via.placeholder.com/60',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
        centerTitle: true, // Center title
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back(); // Navigate back to the previous screen
          },
        ),
        title: Text(
          'Decorate Packages',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenWidth * 0.05, // Dynamic font size
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: decorItems.length,
        itemBuilder: (context, index) {
          return DecorCard(decorItem: decorItems[index]);
        },
      ),
    );
  }
}

class DecorCard extends StatelessWidget {
  final DecorItem decorItem;

  DecorCard({required this.decorItem});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // Dynamic horizontal margin
        vertical: screenWidth * 0.02,  // Dynamic vertical margin
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        contentPadding: EdgeInsets.all(screenWidth * 0.03), // Dynamic padding
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            decorItem.imageUrl,
            width: screenWidth * 0.15, // Dynamic width
            height: screenWidth * 0.15, // Dynamic height
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          decorItem.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Dynamic font size
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              decorItem.description,
              style: TextStyle(fontSize: screenWidth * 0.035), // Dynamic font size
            ),
            SizedBox(height: 4),
          ],
        ),
        trailing: Text(
          '\$${decorItem.price}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Dynamic font size
            color: Colors.blue, // Set price color to blue
          ),
        ),
      ),
    );
  }
}

class DecorItem {
  final String name;
  final String description;
  final int price;
  final String imageUrl;

  DecorItem({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
