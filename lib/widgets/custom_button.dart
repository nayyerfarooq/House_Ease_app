import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final Icon? icon; // Optional icon parameter

  CustomButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.blue,
    this.textColor = Colors.white,
    this.borderRadius = 10.0,
    this.icon, // Initialize optional icon
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ?? SizedBox.shrink(), // Use the icon if provided, otherwise an empty widget
      label: Text(text),
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor,
        backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

