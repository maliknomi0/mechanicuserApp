import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:repair/Utils/loading.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_services/app_services.dart';
import 'package:repair/_services/storage.dart';
import 'package:repair/global/SnackbarHelper.dart';
import 'package:repair/global/globle.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AppService _appService = AppService();

  bool rememberMe = false;
  bool isPasswordVisible = false;

  // ✅ Email Validation
  String? validateEmail(String email) {
    if (email.isEmpty) return "Email is required.";
    if (!EmailValidator.validate(email)) return "Invalid email format.";
    return null;
  }

  // ✅ Password Validation
  String? validatePassword(String password) {
    if (password.isEmpty) return "Password is required.";
    if (password.length < 6) return "Password must be at least 6 characters.";
    return null;
  }

  // ✅ Sign In Method with Loading Dialog
  Future<void> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    showLoader(context, "Logging in..."); // ✅ Show Loading Dialog

    try {
      final response = await _appService.login({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      Navigator.pop(context); // ✅ Hide Loader

      if (response['success']) {
        await Storage.setToken(response['data']['token']);
        await Storage.setLogin(response['data']);
        userSD = response["data"];
        SnackbarHelper.showSuccess(context, "Login successful!");
        Navigator.pushNamed(context, AppRoutes.bottombar);
      } else {
        SnackbarHelper.showError(
            context, "Invalid credentials. Please try again.");
      }
    } catch (e) {
      Navigator.pop(context); // ✅ Hide Loader
      SnackbarHelper.showError(context, e.toString());
    }
  }

  // ✅ Load Saved Credentials from Secure Storage
  Future<void> loadLoginCredentials() async {
    var user = await Storage.getLogin();
    if (user != false) {
      emailController.text = user['email'] ?? '';
      passwordController.text = "";
    }
  }
}
