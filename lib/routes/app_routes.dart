import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';
import '../views/auth/signup.dart';
import '../views/auth/signin.dart';
import '../views/auth/otp_verification.dart';
import '../views/auth/forgot_password_screen.dart';
import '../views/screens/account_setup.dart'; // Add this import

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String accountSetup = '/account-setup'; // Add this route

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      signup: (context) => const SignUp(),
      signin: (context) => const SignInPage(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      accountSetup: (context) => const TripitifyOnboardingScreen(), // Add this
      // Note: OTP verification requires email parameter, handle separately
    };
  }
}