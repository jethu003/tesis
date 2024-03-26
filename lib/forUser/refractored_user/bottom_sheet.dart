import 'package:flutter/material.dart';
import 'package:tesis/utilis/app_colors.dart';

Widget buildButtonContainer({
  required VoidCallback onPressedEdit,
  VoidCallback? onPressedAddReminders,
  required VoidCallback onPressedDelete,
  required String reminderText,
}) {
 

  return Container(
    height: 350,
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'More',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Schyler',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: onPressedEdit,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(315.0, 55.0),
            ),
          ),
          child: const Text('Edit'),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: onPressedAddReminders,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(315.0, 55.0),
            ),
          ),
          child: Text(reminderText),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: onPressedDelete,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            fixedSize: MaterialStateProperty.all<Size>(
              const Size(315.0, 55.0),
            ),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    ),
  );
}
