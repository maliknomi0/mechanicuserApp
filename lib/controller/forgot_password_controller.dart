import 'package:flutter/material.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/global/SnackbarHelper.dart';

class ForgotPasswordController {
  final TextEditingController emailController = TextEditingController();
  final AppService _appService = AppService();

  // ✅ Forgot Password Method with Loader
  Future<void> getOtp(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      SnackbarHelper.showError(context, "Email is required.");
      return;
    }

    showLoader(context, "Sending OTP..."); // ✅ Show Loader

    try {
      final response = await _appService.getotp({"email": email});

      Navigator.pop(context); // ✅ Hide Loader

      if (response['success']) {
        SnackbarHelper.showSuccess(context, response['message']);
        Navigator.pushNamed(context, AppRoutes.OTPVerification,
            arguments: email);
      } else {
        SnackbarHelper.showError(context, response['message']);
      }
    } catch (e) {
      Navigator.pop(context); // ✅ Hide Loader
      SnackbarHelper.showError(context, e.toString());
    }
  }
}
