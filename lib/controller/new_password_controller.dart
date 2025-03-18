import 'package:flutter/material.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/global/SnackbarHelper.dart';

class NewPasswordController {
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // ✅ Password Visibility State
  final AppService _appService = AppService();

  // ✅ Reset Password Method with Loader
  Future<void> resetPassword(
      BuildContext context, String email, String otp) async {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      SnackbarHelper.showError(context, "Password is required.");
      return;
    }

    showLoader(context, "Updating password..."); // ✅ Show Loader

    try {
      final response = await _appService.newPassword({
        "email": email,
        "otp": otp,
        "newPassword": password,
      });

      Navigator.pop(context); // ✅ Hide Loader

      if (response['success']) {
        SnackbarHelper.showSuccess(context, response['message']);
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        SnackbarHelper.showError(context, response['message']);
      }
    } catch (e) {
      Navigator.pop(context); // ✅ Hide Loader
      SnackbarHelper.showError(context, e.toString());
    }
  }

  // ✅ Toggle Password Visibility
  void togglePasswordVisibility(Function setStateCallback) {
    setStateCallback(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }
}
