import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tesis/utilis/app_colors.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final BoxDecoration? boxDecoration;
  final String imagepath;
  final Widget trailing;

  const CustomCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.boxDecoration,
    required this.imagepath,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: boxDecoration ??
          BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.0),
          ),
      child: Card(
        elevation: 20,
        shadowColor: AppColors.backGroundColor,
        child: ListTile(
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          leading: CircleAvatar(
            backgroundImage: FileImage(File(imagepath)),
          ),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: trailing,
        ),
      ),
    );
  }
}
