import 'package:flutter/material.dart';
import 'package:repair/themes/theme_constants.dart';

// Toast Function
void showToast(BuildContext context, {int duration = 3, String msg = ''}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 50.0,
      left: MediaQuery.of(context).size.width * 0.1,
      right: MediaQuery.of(context).size.width * 0.1,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(2, 3),
              ),
            ],
          ),
          child: Text(
            msg,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: lightPrimaryColor, // Change to your desired color
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry into the overlay
  overlay.insert(overlayEntry);

  // Remove the overlay after the specified duration
  Future.delayed(Duration(seconds: duration), () {
    overlayEntry.remove();
  });
}

// Loader Function
void showLoader(BuildContext context, String message) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(p),
          child: CircularProgressIndicator(),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            maxLines: 5,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    ),
  );

  showDialog(
    barrierDismissible: false,
    useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Unfocus Function
void unFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

// Navigator Pop Function
void pop(BuildContext context) {
  Navigator.pop(context);
}
