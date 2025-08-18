import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';
import '../views/auth/signup.dart';
import '../views/auth/signin.dart';
import '../views/auth/otp_verification.dart';

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signup = '/signup';
  static const String signin = '/signin'; // Add this route
  static const String otpVerification = '/otp-verification';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      signup: (context) => const SignUp(),
      signin: (context) => const SignInPage(), // Add this
      // Note: OTP verification requires email parameter, handle separately
    };
  }
}
