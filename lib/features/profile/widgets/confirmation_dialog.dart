import 'package:flutter/material.dart';

class ConfirmationDialogExample {
  VoidCallback onSuccess, onCancel;

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to proceed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onSuccess(); // Perform the action you want to take when the user confirms
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onCancel();
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  ConfirmationDialogExample(
      BuildContext context, this.onSuccess, this.onCancel) {
    _showConfirmationDialog(context);
  }
}
