import 'package:flutter/material.dart';
import '../views/screens/personal/PurposeScreen.dart';
import 'package:tripitify/views/screens/personal/SetupComplete.dart';
import '../views/splash/splash_screen.dart';
import '../views/screens/intro.dart';
import '../views/auth/signup.dart';
import '../views/auth/signin.dart';
import '../views/auth/otp_verification.dart';
import '../views/auth/forgot_password_screen.dart';
import '../views/screens/role_selection_screen.dart';
import '../views/screens/personal/account_setup_screen.dart';
import '../views/screens/personal/TravelPreferencesScreen.dart';
import '../views/screens/Trip_planner/PlannerAccount_setup_screen.dart';
import '../views/screens/Trip_planner/PlannerProfileSetupPage.dart';
import '../views/screens/Trip_planner/PlannerTravelPreferencesScreen.dart';
import '../views/screens/Trip_planner/PlannerSetupComplete.dart';

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
  static const String purpose = '/purpose';
  static const String setupComplete = '/setup-complete';

  // Planner routes
  static const String plannerAccountSetup = '/planner-account-setup';
  static const String plannerProfileSetup = '/planner-profile-setup';
  static const String plannerTravelPreferences =
      '/planner-travel-preferences';
  static const String plannerSetupComplete = '/planner-setup-complete';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      intro: (context) => const IntroPage(),
      signup: (context) => const SignUp(),
      signin: (context) => const SignInPage(),
      forgotPassword: (context) => const ForgotPasswordScreen(),
      otpVerification: (context) => const OtpVerification(
        email: '',
      ),
      accountSetup: (context) => const RoleSelectionScreen(),
      exploreSetup: (context) => const ExploreSetupScreen(),
      travelPreferences: (context) => const TravelPreferencesScreen(),
      purpose: (context) => const LastAccountSetupPage(),
      setupComplete: (context) => const AccountSetupCompleteScreen(),

      // Planner routes
      plannerAccountSetup: (context) => const PlannerAccountSetupScreen(),
      plannerProfileSetup: (context) => const PlannerProfileSetupPage(),
      plannerTravelPreferences: (context) =>
          const PlannerTravelPreferencesScreen(),
      plannerSetupComplete: (context) => const PlannerAccountSetupCompleteScreen(),
    };
  }
}

