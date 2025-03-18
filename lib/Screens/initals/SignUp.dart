import 'package:flutter/material.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/controller/sign_up_controller.dart';
import 'package:repair/themes/theme_constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController _controller =
      SignUpController(); // Controller Instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: _controller.formKey, // Form Key from Controller
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: mediumspascing,
                    children: [
                      Image.asset(
                        AppIamges.Applogo,
                        height: 180,
                      ),
                      SizedBox(height: mediumspascing),
                      CustomTextField(
                          controller: _controller.nameController,
                          hintText: "Name",
                          fieldType: 'name'),
                      CustomTextField(
                          controller: _controller.emailController,
                          hintText: "Email or Phone Number",
                          fieldType: 'email'),
                      CustomTextField(
                          controller: _controller.passwordController,
                          hintText: "Password",
                          isPassword: true,
                          fieldType: 'password'),
                      CustomTextField(
                        controller: _controller.confirmPasswordController,
                        hintText: "Confirm Password",
                        isPassword: true,
                        isConfirmPassword: true,
                        passwordController: _controller.passwordController,
                        fieldType: 'confirmPassword',
                      ),
                      SizedBox(height: smallspascing),
                      SizedBox(
                        height: buttonhight,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () =>
                              _controller.signUp(context, setState),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Text(
                            "Sign Up",
                          ),
                        ),
                      ),
                      SignInRow(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isConfirmPassword;
  final TextEditingController? passwordController;
  final String fieldType;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.isConfirmPassword = false,
    this.passwordController,
    required this.fieldType,
    super.key,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true; // Controls password visibility

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText:
          widget.isPassword ? _isObscured : false, // Toggle password visibility
      decoration: InputDecoration(
        hintText: widget.hintText,

        // Eye icon for password visibility
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          switch (widget.fieldType) {
            case 'name':
              return 'Please enter your name';
            case 'email':
              return 'Please enter a valid email or phone number';
            case 'password':
              return 'Please enter your password';
            case 'confirmPassword':
              return 'Please confirm your password';
            default:
              return 'This field is required';
          }
        }
        if (widget.fieldType == 'email' &&
            !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        if (widget.fieldType == 'password' && value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (widget.isConfirmPassword &&
            widget.passwordController != null &&
            value != widget.passwordController!.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonhight,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}

class SignInRow extends StatelessWidget {
  const SignInRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already remember?", style: TextStyle(color: greyColor)),
        SizedBox(width: 2),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          },
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          child: Text(
            "Sign in",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
