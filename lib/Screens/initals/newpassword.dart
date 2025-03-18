import 'package:flutter/material.dart';
import 'package:repair/controller/new_password_controller.dart'; // ✅ Import Controller

import '../../themes/theme_constants.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final NewPasswordController _controller =
      NewPasswordController(); // ✅ Controller Instance

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final email = arguments['email'];
    final otp = arguments['otp'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Reset Password"),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(p),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Set New Password',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: lagespacing),
                TextField(
                  controller: _controller.passwordController,
                  obscureText: !_controller
                      .isPasswordVisible, // ✅ Use Controller's Visibility State
                  decoration: InputDecoration(
                    hintText: 'New Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _controller.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () =>
                          _controller.togglePasswordVisibility(setState),
                    ),
                  ),
                ),
                const SizedBox(height: lagespacing),
                SizedBox(
                  height: buttonhight,
                  child: ElevatedButton(
                    onPressed: () =>
                        _controller.resetPassword(context, email, otp),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Reset Password',
                        style: TextStyle(color: Colors.white)),
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
