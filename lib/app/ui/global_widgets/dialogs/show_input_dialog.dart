import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<String?> showInputDialog(
  BuildContext context, {
  String? title,
  String? initialValue,
}) async {
  String value = initialValue ?? '';
  TextEditingController controller = TextEditingController();
  controller.text = value;
  final result = await showCupertinoDialog<String>(
    context: context,
    builder: (contexto) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: CupertinoTextField(
        controller: controller,
        onChanged: (text) {
          value = text;
        },
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context, value);
          },
          child: const Text("SAVE"),
          isDefaultAction: true,
        ),
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("CANCEL"),
          isDestructiveAction: true,
        ),
      ],
    ),
  );
  if (result != null && result.trim().isEmpty) {
    return null;
  }
  return result;
}
