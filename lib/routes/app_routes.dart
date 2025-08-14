import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';


class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  // Add other route names

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      // Add other routes
    };
  }
}