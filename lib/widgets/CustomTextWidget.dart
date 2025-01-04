import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size,spacing;
  final FontWeight? weight;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? lines;
  const CustomTextWidget({super.key,
    required this.title,
    this.color,
    this.size,
    this.weight,
    this.spacing,
    this.align,
    this.overflow,
    this.lines
  });
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: spacing,
      ),
      overflow: overflow,
      maxLines: lines,
    );
  }
}
