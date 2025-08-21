import 'package:flutter/material.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';
import '../views/auth/signup.dart';
import '../views/auth/signin.dart';
import '../views/auth/otp_verification.dart';
import '../views/auth/forgot_password_screen.dart';
import '../views/screens/role_selection_screen.dart';
import '../views/screens/explore/account_setup_screen.dart';
import '../views/screens/explore/TravelPreferencesScreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String signup = '/signup';
  static const String signin = '/signin';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerification = '/otp-verification';
  static const String accountSetup = '/account-setup';
  static const String exploreSetup = '/explore-setup';
  static const String travelPreferences = '/travel-preferences';


  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      signup: (context) => const SignUp(),
      signin: (context) => const SignInPage(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      otpVerification: (context) => const OtpVerification(email: '',),
      accountSetup: (context) => const RoleSelectionScreen(),
      exploreSetup: (context) => const ExploreSetupScreen(),
      travelPreferences: (context) => const TravelPreferencesScreen(),
    };
  }
}
