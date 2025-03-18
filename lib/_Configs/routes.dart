import 'package:flutter/material.dart';
import 'package:repair/Screens/initals/newpassword.dart';
import 'package:repair/Screens/initals/onboarding_screen.dart';
import 'package:repair/Screens/initals/otp.dart';
import 'package:repair/Screens/initals/sign_in.dart';
import 'package:repair/Screens/initals/signup.dart';
import 'package:repair/Screens/main/home/HomeScreen.dart';
import 'package:repair/Screens/main/home/chatscreen.dart';
import 'package:repair/Screens/main/home/getstarted.dart';
import 'package:repair/Screens/main/home/googlemapscreen.dart';
import 'package:repair/Screens/main/home/mechanicdetailscreen.dart';

import 'package:repair/Screens/main/nevbar.dart';
import 'package:repair/Screens/main/profile/ChangePasswordScreen.dart';
import 'package:repair/Screens/main/profile/Edit_Profile.dart';
import 'package:repair/Screens/main/profile/TermsAndConditionsScreen.dart';
import 'package:repair/Screens/main/profile/faqs.dart';
import 'package:repair/Screens/main/profile/profile.dart';
import 'package:repair/_Configs/assets.dart';

import '../Screens/initals/forgetpassword.dart';
import '../Screens/initals/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgetPassword = '/forgetpassword';
  static const String emailVerify = '/emailverify';
  static const String dashboard = '/dashboard';
  static const String OTPVerification = '/OTPVerification';
  static const String newPassword = '/newPassword';
  static const String setting = '/setting';
  static const String editProfile = '/EditProfile';
  static const String profile = '/profile';
  static const String articles = '/articles';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String faqs = '/faqs';
  static const String termsAndConditions = '/termsandconditions';
  static const String ChangePassword = '/changepassword';
  static const String getstarted = '/OnBoard';
  static const String homescreen = '/HomeScreen';
  static const String bottombar = '/Bottom';
  static const String TermsAndConditions = '/TermsAndConditions';
  static const String FAQS = '/FAQS';
  static const String mechanicdetailscreen = '/mechanicdetailscreen';
  static const String chatscreen = '/chatscreen';
  static const String googlemaps = '/googlemaps';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const SignInScreen(),
    signup: (context) => const SignUpScreen(),
    forgetPassword: (context) => const ForgotPasswordScreen(),
    OTPVerification: (context) => const OTPVerificationScreen(),
    dashboard: (context) => HomeScreen(),
    newPassword: (context) => const NewPasswordScreen(),
    editProfile: (context) => const EditProfile(),
    ChangePassword: (context) => ChangePasswordScreen(),
    getstarted: (context) => OnBoard(),
    homescreen: (context) => HomeScreen(),
    bottombar: (context) => BottomNavBarScreen(),
    profile: (context) => Profile(),
    TermsAndConditions: (context) => TermsAndConditionsScreen(),
    FAQS: (context) => FAQScreen(),
    mechanicdetailscreen: (context) => MechanicDetails(),
    chatscreen: (context) => ChatScreen(),
    googlemaps: (context) => GoogleMaps(),
  };
}
