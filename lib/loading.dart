import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';


unFocus(BuildContext context) {
  FocusManager.instance.primaryFocus!.unfocus();
}

showLoader(BuildContext dialogContext, message) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(1),
          child: CircularProgressIndicator(
            backgroundColor: lightBackgroundColor,
            color: primaryColor,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Text(
              message,
              maxLines: 5,
              style: const TextStyle(fontSize: 14, fontFamily: 'ns'),
            ),
          ),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: dialogContext,
    builder: (BuildContext dialogContext) {
      return alert;
    },
  );
}


