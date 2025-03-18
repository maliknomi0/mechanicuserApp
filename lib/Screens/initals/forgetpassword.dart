import 'package:flutter/material.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/controller/forgot_password_controller.dart'; // ✅ Import Controller

import '../../themes/theme_constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController _controller =
      ForgotPasswordController(); // ✅ Controller Instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(p),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  AppIamges.Applogo,
                  height: 180,
                ),
                SizedBox(
                  height: lagespacing,
                ),
                Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: lagespacing),
                const Text(
                  'Please enter your registered email address\nto receive a reset password OTP.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: lagespacing),
                TextField(
                  controller: _controller.emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: lagespacing),
                SizedBox(
                  height: buttonhight,
                  child: ElevatedButton(
                    onPressed: () => _controller.getOtp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Send Reset Password',
                        style: TextStyle(color: whiteColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
