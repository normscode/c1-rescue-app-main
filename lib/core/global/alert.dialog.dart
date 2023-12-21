import 'package:flutter/material.dart';

Future<bool> showAlertDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() onTap,
  required Function() onCancel
}) async {

  // set up the button
  Widget okButton = TextButton(
    onPressed: onTap,
    child: const Text("OK"),
  );

  Widget cancelButton = TextButton(
    onPressed: onCancel,
    child: const Text("CANCEL"),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      cancelButton,
      okButton
    ],
  );

  // show the dialog
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}