import 'package:flutter/material.dart';
import 'package:tesis/utilis/app_colors.dart';

class MyListTile extends StatelessWidget {
  final Widget leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget trailing;

  const MyListTile({
    super.key,
    required this.leading,
    this.title,
    this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteForText),
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
        ),
      ),
    );
  }
}
