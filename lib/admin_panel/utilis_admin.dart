
import 'package:flutter/material.dart';

class FirebasFunctions {
  Future<void> addRecomendations() async {
    
  }

  Widget showDialogueDelete(BuildContext context, callback) {
    return AlertDialog(
      content: const Text('Are you sure want to delete this'),
      actions: [
        TextButton(
          onPressed: callback,
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
