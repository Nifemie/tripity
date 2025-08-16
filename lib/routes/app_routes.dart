import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';
import '../views/auth/signup.dart'; // Add this import

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signup = '/signup'; // Add this route

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      signup: (context) => const SignUp(), // Add this route
    };
  }
}