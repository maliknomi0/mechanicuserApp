import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/global/SnackbarHelper.dart';

class SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AppService _appService = AppService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // ✅ Sign Up Method with Loading Dialog
  Future<void> signUp(BuildContext context, Function setStateCallback) async {
    if (!formKey.currentState!.validate()) return;

    showLoader(context, "Creating your account..."); // ✅ Show Loader

    Map<String, dynamic> data = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    try {
      var response = await _appService.signup(data);

      Navigator.pop(context); // ✅ Hide Loader

      if (response['success']) {
        if (response.containsKey('token')) {
          await _storage.write(key: "authToken", value: response['token']);
        }

        SnackbarHelper.showSuccess(
            context, "Signup successful! Please log in.");
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        String errorMessage =
            response['message'] ?? "Signup failed. Please try again.";
        SnackbarHelper.showError(context, errorMessage);
      }
    } catch (e) {
      Navigator.pop(context); // ✅ Hide Loader
      SnackbarHelper.showError(context, e.toString());
    }
  }
}
