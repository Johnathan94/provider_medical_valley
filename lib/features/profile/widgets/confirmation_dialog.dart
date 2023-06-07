import 'package:flutter/material.dart';

class ConfirmationDialogExample {
  VoidCallback onSuccess, onCancel;

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure you want to proceed?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                onCancel(); // Perform the action you want to take when the user confirms
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onSuccess();
              },
              child: Text('No'),
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
