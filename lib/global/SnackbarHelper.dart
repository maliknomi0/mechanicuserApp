import 'package:flutter/material.dart';

class SnackbarHelper {
  // Show Success Snackbar
  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  // Show Error Snackbar
  static void showError(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  // Show Warning Snackbar
  static void showWarning(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }

  // Show Info Snackbar
  static void showInfo(BuildContext context, String message) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  // Private method to show the styled Snackbar
  static void _showSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    required IconData icon,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      duration: const Duration(seconds: 3),
    );

    // Show the Snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
