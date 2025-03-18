import 'package:flutter/material.dart';
import 'package:repair/_Configs/assets.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_Configs/size_config.dart';
import 'package:repair/_services/storage.dart';
import 'package:repair/global/globle.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _navigateBasedOnState);
  }

  // ✅ Check Storage for User Login
  Future<void> _navigateBasedOnState() async {
    final String token =
        await Storage.getToken(); // ✅ Get token from Secure Storage
    final dynamic user =
        await Storage.getLogin(); // ✅ Get user data from Secure Storage

    if (token.isNotEmpty && user != false) {
      userSD = user; // ✅ Set Global User Data
      print(userSD);
      Navigator.pushReplacementNamed(context, AppRoutes.bottombar);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtils(context); // Initialize responsive utilities

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(seconds: 2),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.easeInOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child:
                        Image.asset(AppIamges.Applogo, height: r.height(0.3)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
