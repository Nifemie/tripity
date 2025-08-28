import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../routes/app_routes.dart';


class AccountSetupCompleteScreen extends ConsumerWidget {
  const AccountSetupCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Spacer to center content vertically
              const Spacer(flex: 2),

              // Icon with circular background
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/account_setup/User.svg',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Welcome message
              const Text(
                'Welcome aboard, Benjamin 🎉',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.375, // 33px / 24px = 1.375
                  letterSpacing: 0,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description text
              const Text(
                'Your traveller profile is ready. Let\'s help you discover exciting trips and personalized recommendations.',
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5, // 21px / 14px = 1.5
                ),
                textAlign: TextAlign.center,
              ),

              // Spacer to push button to bottom
              const Spacer(flex: 3),

              // Go to Dashboard Button
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: const LinearGradient(
                    begin: Alignment(-0.04, -1.0),
                    end: Alignment(1.07, 1.0),
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF2563EB),
                      Color(0xFF1E40AF),
                    ],
                    stops: [0.0, 0.5145, 1.0712],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  child: const Text(
                    'Go to Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}