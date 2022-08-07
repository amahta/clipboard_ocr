import 'package:flutter/material.dart';

void showSnackBar(
    BuildContext context, String message, Color? backgroundColor) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor,
      content: Text(message),
    ),
  );
}

Future<String?> showTextInputDialog(BuildContext context, String label) async {
  final textController = TextEditingController();
  String? result;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Enter $label'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(hintText: label),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              result = textController.text;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
  return result;
}

Future<String?> showBinaryChoiceDialog(
  BuildContext context,
  String title,
  String option1,
  String option2,
) async {
  String? result;
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        actions: [
          ElevatedButton(
            child: Text(option1),
            onPressed: () {
              result = option1;
              Navigator.pop(context);
            },
          ),
          ElevatedButton(
            child: Text(option2),
            onPressed: () {
              result = option2;
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
  return result;
}
