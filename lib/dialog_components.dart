import 'package:flutter/material.dart';

enum AlertAction { cancel, ok }

class DialogComponents {
  static snackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  static Future<AlertAction?> confirmDialog(
      BuildContext context, String message) async {
    return showDialog<AlertAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Row(
            children: [
              Text('Confirm!', style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Icon(
                Icons.info,
                size: 35,
              ),
            ],
          ),
          content: Text(
            message.toString(),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(AlertAction.cancel);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              style: ButtonStyle(),
              onPressed: () {
                Navigator.of(context).pop(AlertAction.ok);
              },
              child: const Text(
                "Ok",
              ),
            ),
          ],
        );
      },
    );
  }
}
