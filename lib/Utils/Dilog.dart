// Reusable Input Dialog
import 'package:flutter/material.dart';

Future<void> showInputDialog({
  required BuildContext context,
  required String title,
  required String labelText,
  required String initialValue,
  required Function(String value) onConfirm,
  String confirmButtonText = 'Update',
  String cancelButtonText = 'Cancel',
  TextInputType keyboardType = TextInputType.text,
}) async {
  final TextEditingController controller =
      TextEditingController(text: initialValue);

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            final value = controller.text.trim();
            onConfirm(value);
            Navigator.pop(context);
          },
          child: Text(confirmButtonText),
        ),
      ],
    ),
  );
}
