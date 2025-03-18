import 'package:flutter/material.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/controller/signin_controller.dart';
import 'package:repair/themes/theme_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController _controller = SignInController();

  @override
  void initState() {
    super.initState();
    _controller.loadLoginCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: p),
                child: Form(
                  key: _controller.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppIamges.Applogo,
                        height: 180,
                      ),
                      SizedBox(height: lagespacing),
                      TextFormField(
                        controller: _controller.emailController,
                        decoration: InputDecoration(
                          hintText: "Email or Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => _controller.validateEmail(value!),
                      ),
                      SizedBox(height: mediumspascing),
                      TextFormField(
                        controller: _controller.passwordController,
                        obscureText: !_controller.isPasswordVisible,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _controller.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _controller.isPasswordVisible =
                                    !_controller.isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) =>
                            _controller.validatePassword(value!),
                      ),
                      SizedBox(height: mediumspascing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _controller.rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _controller.rememberMe = value!;
                                  });
                                },
                                checkColor: whiteColor,
                              ),
                              Text("Remember Me",
                                  style: TextStyle(color: lightPrimaryColor)),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.forgetPassword),
                            child: Text("Forgot Password?",
                                style: TextStyle(color: lightPrimaryColor)),
                          ),
                        ],
                      ),
                      SizedBox(height: mediumspascing),
                      SizedBox(
                        height: buttonhight,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _controller.login(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Text("Sign in",
                              style: TextStyle(color: whiteColor)),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: TextStyle(color: greyColor)),
                          SizedBox(width: 2),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: Text("Sign up",
                                style: TextStyle(
                                    // color: primaryColor,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(height: mediumspascing),
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
