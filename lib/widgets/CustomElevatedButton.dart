import 'package:flutter/material.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color? color,backcolor;
  final VoidCallback path;
  final double? padding,radius,fontsize,width,height;

  const CustomElevatedButton({super.key,
    required this.text,
    required this.color,
    required this.path,
    this.padding,
    this.radius,
    this.fontsize,
    this.backcolor,
    this.width=double.infinity,
    this.height=60,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:path,
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!),
          ),
          padding: EdgeInsets.symmetric(vertical: padding!),
          minimumSize: Size(width!,height!),
        ),
        child:CustomTextWidget(title: text,size: fontsize,)
    )  ;
  }
}
