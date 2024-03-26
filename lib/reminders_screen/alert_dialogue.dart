import 'package:flutter/material.dart';
import 'package:tesis/utilis/app_colors.dart';

class RemindDialog extends StatelessWidget {
  final String title;
  final List<Widget> actions;

  const RemindDialog({
    super.key,
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          letterSpacing: 1,
          fontWeight: FontWeight.w900,
          color: AppColors.primaryColor,
          fontFamily: 'Schyler',
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );
  }
}
