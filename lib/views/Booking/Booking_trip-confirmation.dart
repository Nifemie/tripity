import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/Bookings_widget/Bookings_cta_button.dart';

// ==================== BOOKING TRIP CONFIRMATION PAGE ====================

class BookingTripConfirmationPage extends ConsumerWidget {
  final String tripName;
  final String experienceName;

  const BookingTripConfirmationPage({
    Key? key,
    this.tripName = 'European Getaway',
    this.experienceName = 'Paris Walking Tour: Montmartre & Artists',
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Success Icon
                SvgPicture.asset(
                  'assets/images/Trips/success_icon.svg',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 32),

                // Success Heading
                const Text(
                  'Added to Trip!',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.33,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Success Message
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(text: experienceName),
                      const TextSpan(text: ' has been added to your '),
                      TextSpan(
                        text: tripName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                        ),
                      ),
                      const TextSpan(text: ' trip'),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Primary Button - View Trip Plan
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () {
                      _viewTripPlan(context);
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9999),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.0421, -1.0),
                          end: Alignment(1.0712, 1.0),
                          colors: [
                            Color(0xFF3B82F6),
                            Color(0xFF2563EB),
                            Color(0xFF1E40AF),
                          ],
                          stops: [0.0, 0.5145, 1.0],
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.card_travel,
                            size: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'View Trip Plan',
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Secondary Button - Continue Exploring
                SizedBox(
                  width: double.infinity,
                  child: CtaButton(
                    text: 'Continue Exploring',
                    onPressed: () {
                      _continueExploring(context);
                    },
                    isPrimary: false,
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== ACTION METHODS ====================

  void _viewTripPlan(BuildContext context) {
    // Navigate to trip details/plan view
    context.go('/trip-summary');
  }

  void _continueExploring(BuildContext context) {
    // Navigate back to experiences or home
    context.go('/experiences');
  }
}
