import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tripitify/views/onboarding_screens/screens/personal/PurposeScreen.dart';
import 'package:tripitify/views/onboarding_screens/screens/personal/SetupComplete.dart';
import 'package:tripitify/views/splash/splash_screen.dart';
import 'package:tripitify/views/onboarding_screens/screens/intro.dart';
import 'package:tripitify/views/onboarding_screens/auth/signup.dart';
import 'package:tripitify/views/onboarding_screens/auth/signin.dart';
import 'package:tripitify/views/onboarding_screens/auth/otp_verification.dart';
import 'package:tripitify/views/onboarding_screens/auth/forgot_password_screen.dart';
import 'package:tripitify/views/onboarding_screens/screens/role_selection_screen.dart';
import 'package:tripitify/views/onboarding_screens/screens/personal/account_setup_screen.dart';
import 'package:tripitify/views/onboarding_screens/screens/personal/TravelPreferencesScreen.dart';
import 'package:tripitify/views/onboarding_screens/screens/Trip_planner/PlannerAccount_setup_screen.dart';
import 'package:tripitify/views/onboarding_screens/screens/Trip_planner/PlannerProfileSetupPage.dart';
import 'package:tripitify/views/onboarding_screens/screens/Trip_planner/PlannerTravelPreferencesScreen.dart';
import 'package:tripitify/views/onboarding_screens/screens/Trip_planner/PlannerSetupComplete.dart';
import 'package:tripitify/views/home_screens/HomeScreen.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/plan_trip.dart';
import 'package:tripitify/views/home_screens/search_screen.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/self_plan/self_planSetup.dart';
import 'package:tripitify/views/Explore_screen/Trip_view.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/intro',
      builder: (BuildContext context, GoRouterState state) => const IntroPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) => const SignUp(),
    ),
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) => const SignInPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (BuildContext context, GoRouterState state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (BuildContext context, GoRouterState state) {
        final email = state.extra as String? ?? '';
        return OtpVerification(email: email);
      },
    ),
    GoRoute(
      path: '/account-setup',
      builder: (BuildContext context, GoRouterState state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/account-setup-details',
      builder: (BuildContext context, GoRouterState state) {
        final role = state.extra as String?;
        return AccountSetupScreen(role: role);
      },
    ),
    GoRoute(
      path: '/travel-preferences',
      builder: (BuildContext context, GoRouterState state) => const TravelPreferencesScreen(),
    ),
    GoRoute(
      path: '/purpose',
      builder: (BuildContext context, GoRouterState state) => const PurposeScreen(),
    ),
    GoRoute(
      path: '/setup-complete',
      builder: (BuildContext context, GoRouterState state) => const SetupComplete(),
    ),
    GoRoute(
      path: '/planner-account-setup',
      builder: (BuildContext context, GoRouterState state) => const PlannerAccountSetupScreen(),
    ),
    GoRoute(
      path: '/planner-profile-setup',
      builder: (BuildContext context, GoRouterState state) => const PlannerProfileSetupPage(),
    ),
    GoRoute(
      path: '/planner-travel-preferences',
      builder: (BuildContext context, GoRouterState state) => const PlannerTravelPreferencesScreen(),
    ),
    GoRoute(
      path: '/planner-setup-complete',
      builder: (BuildContext context, GoRouterState state) => const PlannerSetupComplete(),
    ),
    GoRoute(
      path: '/HomeScreen',
      builder: (BuildContext context, GoRouterState state) => HomeScreen(),
    ),
    GoRoute(
      path: '/plan-new-trip',
      builder: (BuildContext context, GoRouterState state) => const PlanNewTripPage(),
    ),
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) => const SearchScreen(),
    ),
    GoRoute(
      path: '/self-plan-setup',
      builder: (BuildContext context, GoRouterState state) => const TripBasicDetailsPage(),
    ),
    GoRoute(
      path: '/trip-view',
      builder: (BuildContext context, GoRouterState state) => const TravelTipDetailPage(),
    ),
  ],
);