import 'package:flutter/material.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/_services/storage.dart';
import 'package:repair/global/SnackbarHelper.dart';
import 'package:repair/global/globle.dart';

class DeleteProfileController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AppService _appService = AppService();

  void loadUserData() {
    var user = userSD["user"];

    if (user is Map) {
      emailController.text = user["email"]?.toString() ?? '';
    } else {
      print(
          "❌ ERROR: userSD['user'] is not a Map! Actual type: ${user.runtimeType}");
    }
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> deleteUser(BuildContext context) async {
    try {
      Map<String, dynamic> data = {
        "id": userSD['user']['id'],
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      };

      final response = await _appService.deleteUserProfile(data);
      showLoader(context, "Deleting Profile...");

      if (response["success"] == true) {
        await _logout(context);

        SnackbarHelper.showSuccess(context, "Profile deleted successfully.");
      } else {
        SnackbarHelper.showError(
            context, response['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      SnackbarHelper.showError(
          context, "Failed to delete profile. Please try again.");
    }
  }
}

Future<void> _logout(BuildContext context) async {
  bool isLoggedOut = await Storage.logout();
  if (isLoggedOut) {
    userSD = null;
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.login, (route) => false);
  }
}
