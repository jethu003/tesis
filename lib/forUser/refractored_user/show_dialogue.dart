import 'package:flutter/material.dart';
class ShowDialog extends StatefulWidget {
  final VoidCallback onPressed;
  const ShowDialog({Key? key, required this.onPressed}) : super(key: key);
  @override
  State<ShowDialog> createState() => _ShowDialogState();
}
class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Item"),
      content: const Text("Are you sure you want to delete this item?"),
      actions: [
        TextButton(
          onPressed: () {
            widget.onPressed();
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            widget.onPressed();
            Navigator.of(context).pop();
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
