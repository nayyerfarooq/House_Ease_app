import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllInOnePackagesPage extends StatelessWidget {
  final List<Hotel> hotels = [
    Hotel(
      name: 'President Hotel',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 35,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'President Hotel',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 35,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'Palms Casino',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 45,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'Hotel The Match',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 55,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'Blue Collar Hotel',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 40,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'Little Grand Hotel',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 30,
      imageUrl: 'https://via.placeholder.com/60',
    ),
    Hotel(
      name: 'Blue Collar Hotel',
      location: 'Paris, France',
      rating: 4.5,
      reviews: 5500,
      price: 40,
      imageUrl: 'https://via.placeholder.com/60',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'All in One Packages',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.width * 0.05, // Dynamic font size
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return HotelCard(hotel: hotels[index]);
        },
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;

  HotelCard({required this.hotel});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      color: Colors.white, // Set the card color to white
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenWidth * 0.02, // Responsive vertical margin
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        contentPadding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            hotel.imageUrl,
            width: screenWidth * 0.15, // Responsive width for image
            height: screenWidth * 0.15, // Maintain aspect ratio
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          hotel.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Responsive font size
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hotel.location,
              style: TextStyle(fontSize: screenWidth * 0.035), // Responsive font size
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04), // Responsive icon size
                SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '${hotel.rating} (${hotel.reviews} reviews)',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: screenWidth * 0.035), // Responsive font size
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Text(
          '\$${hotel.price}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.045, // Responsive font size
            color: Colors.blue, // Set the price color to blue
          ),
        ),
      ),
    );
  }
}

class Hotel {
  final String name;
  final String location;
  final double rating;
  final int reviews;
  final String imageUrl;
  final int price;

  Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.price,
  });
}
