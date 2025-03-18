import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/global/SnackbarHelper.dart';

class OTPVerificationController {
  final List<TextEditingController> otpControllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final AppService _appService = AppService();

  int remainingTime = 60;
  late Timer _timer;
  bool canResend = false;

  // ✅ Start Countdown Timer
  void startTimer(Function setStateCallback) {
    setStateCallback(() {
      remainingTime = 60;
      canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setStateCallback(() {
          remainingTime--;
        });
      } else {
        timer.cancel();
        setStateCallback(() {
          canResend = true;
        });
      }
    });
  }

  // ✅ Resend OTP Method with Loader
  Future<void> resendOTP(
      BuildContext context, Function setStateCallback, String email) async {
    if (canResend) {
      showLoader(context, "Resending OTP..."); // ✅ Show Loader

      try {
        final response = await _appService.getotp({"email": email});

        Navigator.pop(context); // ✅ Hide Loader

        if (response['success']) {
          SnackbarHelper.showSuccess(context, response['message']);
          startTimer(setStateCallback); // Restart timer after resending
        } else {
          SnackbarHelper.showError(context, response['message']);
        }
      } catch (e) {
        Navigator.pop(context); // ✅ Hide Loader
        SnackbarHelper.showError(context, e.toString());
      }
    }
  }

  // ✅ Verify OTP Method with Loader
  Future<void> verifyOTP(
      BuildContext context, Function setStateCallback, String email) async {
    final otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      SnackbarHelper.showError(
          context, "Please enter all 4 digits of the OTP.");
      return;
    }

    showLoader(context, "Verifying OTP..."); // ✅ Show Loader

    try {
      final response =
          await _appService.verifyOtp({"email": email, "otp": otp});

      Navigator.pop(context); // ✅ Hide Loader

      if (response['success']) {
        SnackbarHelper.showSuccess(context, response['message']);
        Navigator.pushNamed(context, AppRoutes.newPassword,
            arguments: {"email": email, "otp": otp});
      } else {
        SnackbarHelper.showError(context, response['message']);
      }
    } catch (e) {
      Navigator.pop(context); // ✅ Hide Loader
      SnackbarHelper.showError(context, e.toString());
    }
  }

  // ✅ Dispose Controllers & Timer
  void dispose() {
    _timer.cancel();
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
  }
}
