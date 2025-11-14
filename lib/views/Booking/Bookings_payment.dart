import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/providers/booking_providers.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/Bookings_widget/Bookings_cta_button.dart';

// ==================== PAYMENT METHOD PROVIDER ====================

final selectedPaymentMethodProvider = StateProvider<String>((ref) => 'wallet');

// ==================== PAYMENT & CONFIRMATION PAGE ====================

class PaymentConfirmationPage extends ConsumerWidget {
  const PaymentConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPaymentMethod = ref.watch(selectedPaymentMethodProvider);
    final numberOfTravelers = ref.watch(numberOfTravelersProvider);
    final serviceFee = ref.watch(serviceFeeProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final currentStep = ref.watch(bookingStepProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            ref.read(bookingStepProvider.notifier).state = 2;
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Payment & Confirmation',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$currentStep/3',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Bar
          const SizedBox(height: 8),
          TripProgressBar(currentStep: currentStep, totalSteps: 3),
          const SizedBox(height: 24),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary Section
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildOrderSummary(
                      numberOfTravelers,
                      serviceFee,
                      totalPrice,
                    ),
                    const SizedBox(height: 24),

                    // Payment Method Section
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentMethods(ref, selectedPaymentMethod),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom CTA Buttons
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
            ),
            child: SafeArea(
              child: Column(
                // Changed to Column to hold both text and row of buttons
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTermsText(), // Moved here
                  const SizedBox(
                      height: 16), // Spacing between text and buttons
                  Row(
                    children: [
                      // Cancel Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showCancelDialog(context);
                          },
                          child: Container(
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9999),
                              color: const Color(0xFFF3F4F6),
                            ),
                            child: const Center(
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Confirm Booking Button
                      Expanded(
                        child: CtaButton(
                          text: 'Confirm Booking',
                          onPressed: () {
                            _confirmBooking(context, ref);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== ORDER SUMMARY ====================

  Widget _buildOrderSummary(int travelers, double serviceFee, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172554).withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Experience Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/Bookings/experience/paris_walking.png',
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Experience Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paris Walking Tour: Montmartre & Artists',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'by Paris Walking Tours',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280).withOpacity(0.8),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: const Color(0xFFF3F4F6)),
          const SizedBox(height: 16),

          // Travelers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Travelers:',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              Text(
                '$travelers',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Service Fee
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service fee:',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              Text(
                '\$${serviceFee.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: const Color(0xFFF3F4F6)),
          const SizedBox(height: 16),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3B82F6),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== PAYMENT METHODS ====================

  Widget _buildPaymentMethods(WidgetRef ref, String selectedMethod) {
    return Column(
      children: [
        // Tripify Wallet
        GestureDetector(
          onTap: () {
            ref.read(selectedPaymentMethodProvider.notifier).state = 'wallet';
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selectedMethod == 'wallet'
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFF3F4F6),
                width: 1,
              ),
              color: selectedMethod == 'wallet'
                  ? const Color(0xFFEFF6FF)
                  : const Color(0xFFF3F4F6),
            ),
            child: Row(
              children: [
                // Wallet Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF3B82F6),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tripify Wallet',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '\$150.00 available',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280).withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Check Icon
                if (selectedMethod == 'wallet')
                  SvgPicture.asset(
                    'assets/images/Trips/blue_Check_Circle.svg',
                    width: 24,
                    height: 24,
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Pay Online
        GestureDetector(
          onTap: () {
            ref.read(selectedPaymentMethodProvider.notifier).state = 'online';
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selectedMethod == 'online'
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFF3F4F6),
                width: 1,
              ),
              color: selectedMethod == 'online'
                  ? const Color(0xFFEFF6FF)
                  : const Color(0xFFF3F4F6),
            ),
            child: Row(
              children: [
                // Globe Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    // Changed to const as color is now fixed
                    color: Colors.white, // Always white background
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/Trips/Global.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF6B7280),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pay Online',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Paypal, Paystack',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280).withOpacity(0.8),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Check Icon
                if (selectedMethod == 'online')
                  SvgPicture.asset(
                    'assets/images/Trips/blue_Check_Circle.svg',
                    width: 24,
                    height: 24,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== TERMS TEXT ====================

  Widget _buildTermsText() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'Instrument Sans',
          fontSize: 10,
          fontWeight: FontWeight.w400,
          color: Color(0xFF6B7280),
          height: 1.5,
        ),
        children: [
          TextSpan(text: 'By proceeding, you agree to our '),
          TextSpan(
            text: 'Terms of Use',
            style: TextStyle(
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== CANCEL DIALOG ====================

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: const Text(
            'Cancel Booking?',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
            ),
          ),
          content: const Text(
            'Are you sure you want to cancel this booking? All your entered information will be lost.',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'No, Continue',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Yes, Cancel',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==================== CONFIRM BOOKING ====================

  void _confirmBooking(BuildContext context, WidgetRef ref) {
    // Navigate to booking confirmed page
    context.push('/booking-confirmed');
  }
}
