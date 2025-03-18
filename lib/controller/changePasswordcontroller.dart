import 'package:flutter/material.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/global/SnackbarHelper.dart';
import 'package:repair/global/globle.dart';

import '../Utils/loading.dart';

class ChangePasswordController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final AppService _appService = AppService();

  Future<void> changePassword(BuildContext context) async {
    final email = userSD["user"]["email"];
    final oldPassword = oldPasswordController.text.trim();
    final newPassword = newPasswordController.text.trim();

    if (email.isEmpty || oldPassword.isEmpty || newPassword.isEmpty) {
      SnackbarHelper.showError(context, "All fields are required.");
      return;
    }

    if (newPassword.length < 6) {
      SnackbarHelper.showError(
          context, "New password must be at least 6 characters long.");
      return;
    }

    showLoader(context, "Changing password...");

    try {
      final response = await _appService.changepassord({
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });

      Navigator.of(context, rootNavigator: true).pop(); // Hide loader

      if (response['success'] == true) {
        SnackbarHelper.showSuccess(context, "Password changed successfully.");
        _clearFields();
        Navigator.of(context).pop(); // Go back to the previous page
      } else {
        SnackbarHelper.showError(
            context, response['message'] ?? "Failed to change password.");
      }
    } catch (error) {
      Navigator.of(context, rootNavigator: true).pop(); // Hide loader
      SnackbarHelper.showError(context, error.toString());
    }
  }

  void _clearFields() {
    oldPasswordController.clear();
    newPasswordController.clear();
  }

  void disposeControllers() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
  }
}
