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
import 'package:tripitify/views/Trips_screen/plan_trip/self_plan/trip_preference.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/self_plan/Itinerary.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/self_plan/TripSummary.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/self_plan/complete_tripsetup.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/search_planner.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/planner_payment.dart';
import 'package:tripitify/views/Booking/bookings.dart';
import 'package:tripitify/views/Booking/transport.dart';
import 'package:tripitify/views/Booking/stays.dart';
import 'package:tripitify/views/Booking/stays_details.dart';
import 'package:tripitify/views/Booking/experiences.dart';
import 'package:tripitify/views/Booking/events.dart';
import 'package:tripitify/views/Booking/experience_details.dart';
import 'package:tripitify/views/Booking/booking_details.dart';
import 'package:tripitify/views/Booking/personal_details.dart';
import 'package:tripitify/views/Booking/Bookings_payment.dart';
import 'package:tripitify/views/Booking/booking_confirmed.dart';
import 'package:tripitify/views/Booking/add_to_trip.dart';
import 'package:tripitify/views/Booking/Booking_trip-confirmation.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder:
          (BuildContext context, GoRouterState state) => const SplashScreen(),
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
      builder:
          (BuildContext context, GoRouterState state) => const SignInPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder:
          (BuildContext context, GoRouterState state) =>
              const ForgotPasswordScreen(),
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
      builder:
          (BuildContext context, GoRouterState state) =>
              const RoleSelectionScreen(),
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
      builder:
          (BuildContext context, GoRouterState state) =>
              const TravelPreferencesScreen(),
    ),
    GoRoute(
      path: '/purpose',
      builder:
          (BuildContext context, GoRouterState state) => const PurposeScreen(),
    ),
    GoRoute(
      path: '/setup-complete',
      builder:
          (BuildContext context, GoRouterState state) => const SetupComplete(),
    ),
    GoRoute(
      path: '/planner-account-setup',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PlannerAccountSetupScreen(),
    ),
    GoRoute(
      path: '/planner-profile-setup',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PlannerProfileSetupPage(),
    ),
    GoRoute(
      path: '/planner-travel-preferences',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PlannerTravelPreferencesScreen(),
    ),
    GoRoute(
      path: '/planner-setup-complete',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PlannerSetupComplete(),
    ),
    GoRoute(
      path: '/HomeScreen',
      builder: (BuildContext context, GoRouterState state) => HomeScreen(),
    ),
    GoRoute(
      path: '/plan-new-trip',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PlanNewTripPage(),
    ),
    // GoRoute(
    //   path: '/search',
    //   builder: (BuildContext context, GoRouterState state) => const SearchScreen(),
    // ),
    GoRoute(
      path: '/self-plan-setup',
      builder: (BuildContext context, GoRouterState state) {
        final fromPlanner = state.uri.queryParameters['fromPlanner'] == 'true';
        return TripBasicDetailsPage(fromPlanner: fromPlanner);
      },
    ),
    GoRoute(
      path: '/trip-preference',
      builder: (BuildContext context, GoRouterState state) {
        final fromPlanner = state.extra as bool? ?? false;
        return TripPreferencesScreen(fromPlanner: fromPlanner);
      },
    ),
    GoRoute(
      path: '/itinerary',
      builder: (BuildContext context, GoRouterState state) {
        final fromPlanner = state.extra as bool? ?? false;
        return ItineraryScreen(fromPlanner: fromPlanner);
      },
    ),
    GoRoute(
      path: '/trip-summary',
      builder: (BuildContext context, GoRouterState state) {
        final fromPlanner = state.extra as bool? ?? false;
        return TripSummaryScreen(fromPlanner: fromPlanner);
      },
    ),
    GoRoute(
      path: '/trip-ready',
      builder:
          (BuildContext context, GoRouterState state) =>
              const TripReadyScreen(),
    ),
    GoRoute(
      path: '/search-planner',
      builder:
          (BuildContext context, GoRouterState state) =>
              const DestinationSelectionScreen(),
    ),
    GoRoute(
      path: '/trip-view',
      builder:
          (BuildContext context, GoRouterState state) =>
              const TravelTipDetailPage(),
    ),
    GoRoute(
      path: '/planner-payment',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PaymentConfirmationScreen(),
    ),
    GoRoute(
      path: '/transport',
      builder:
          (BuildContext context, GoRouterState state) => const TransportPage(),
    ),
    GoRoute(
      path: '/stays',
      builder: (BuildContext context, GoRouterState state) => const StaysPage(),
    ),
    GoRoute(
      path: '/experiences',
      builder:
          (BuildContext context, GoRouterState state) =>
              const ExperiencesPage(),
    ),
    GoRoute(
      path: '/events',
      builder:
          (BuildContext context, GoRouterState state) => const EventsPage(),
    ),
    GoRoute(
      path: '/experience-details',
      builder:
          (BuildContext context, GoRouterState state) =>
              const ExperienceDetailsPage(),
    ),
    GoRoute(
      path: '/stays-details',
      builder:
          (BuildContext context, GoRouterState state) =>
              const StaysDetailsPage(),
    ),
    GoRoute(
      path: '/booking-details',
      builder:
          (BuildContext context, GoRouterState state) =>
              const BookingDetailsPage(),
    ),
    GoRoute(
      path: '/personal-details',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PersonalDetailsPage(),
    ),
    GoRoute(
      path: '/payment-confirmation',
      builder:
          (BuildContext context, GoRouterState state) =>
              const PaymentConfirmationPage(),
    ),
    GoRoute(
      path: '/booking-confirmed',
      builder:
          (BuildContext context, GoRouterState state) =>
              const BookingConfirmedPage(),
    ),
    GoRoute(
      path: '/add-to-trip',
      builder:
          (BuildContext context, GoRouterState state) => const AddToTripPage(),
    ),
    GoRoute(
      path: '/trip-confirmation',
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, String>?;
        return BookingTripConfirmationPage(
          tripName: extra?['tripName'] ?? 'European Getaway',
          experienceName:
              extra?['experienceName'] ??
              'Paris Walking Tour: Montmartre & Artists',
        );
      },
    ),
  ],
);
