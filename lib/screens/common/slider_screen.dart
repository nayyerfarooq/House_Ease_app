import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class SliderScreen extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const SliderScreen({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: 300),
        const SizedBox(height: 20),
        CustomTextWidget(
         title:  title,
            size: 24,
            weight: FontWeight.bold,
            color: Colors.yellow,
        ),
        const SizedBox(height: 10),
        CustomTextWidget(
          title: description,
          align: TextAlign.center,
          size: 16, color: Colors.black,
        ),
      ],
    );
  }
}
