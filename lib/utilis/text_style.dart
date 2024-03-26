import 'package:flutter/material.dart';
import 'package:tesis/utilis/app_colors.dart';

class CustomTextStyle extends StatelessWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final String fontFamily;
  final double letterSpacing;
  final String text;

  const CustomTextStyle({
    Key? key,
    required this.text,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.color = AppColors.primaryColor,
    this.fontFamily = 'Schyler',
    this.letterSpacing = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontFamily: fontFamily,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
