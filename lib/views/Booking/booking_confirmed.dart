import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/providers/booking_providers.dart';
import 'package:tripitify/widgets/Bookings_widget/Bookings_cta_button.dart';

// ==================== BOOKING CONFIRMED PAGE ====================

class BookingConfirmedPage extends ConsumerWidget {
  const BookingConfirmedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final numberOfTravelers = ref.watch(numberOfTravelersProvider);
    final basePrice = ref.watch(basePricePerPersonProvider);
    final serviceFee = ref.watch(serviceFeeProvider);
    final totalPrice = ref.watch(totalPriceProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // Success Icon
                SvgPicture.asset(
                  'assets/images/Trips/success_icon.svg',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 24),

                // Heading
                const Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.33,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Subtext
                const Text(
                  'Your activity booking has been confirmed. You\'ll receive a confirmation email shortly.',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Download and Share Buttons
                Row(
                  children: [
                    // Download Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _downloadBooking();
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
                              SvgPicture.asset(
                                'assets/images/Trips/Download_icon.svg',
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  Colors.white,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Download',
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
                    const SizedBox(width: 12),

                    // Share Booking Button
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _shareBooking();
                        },
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFD1D5DB),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/Trips/Share.svg',
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  Color(0xFF111827),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Share Booking',
                                style: TextStyle(
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Booking Summary Section
                _buildBookingSummaryCard(),
                const SizedBox(height: 24),

                // Confirmation Details Section
                _buildConfirmationDetailsCard(),
                const SizedBox(height: 24),

                // Activity Details Section
                _buildActivityDetailsCard(numberOfTravelers),
                const SizedBox(height: 24),

                // Pricing Breakdown Section
                _buildPricingBreakdownCard(
                    basePrice, numberOfTravelers, serviceFee, totalPrice),
                const SizedBox(height: 24),

                // What's Next Section
                _buildSectionTitle('What\'s Next?'),
                const SizedBox(height: 12),
                _buildWhatsNextCard(),
                const SizedBox(height: 32),

                // Bottom Action Buttons
                Row(
                  children: [
                    // Continue Exploring Button
                    Expanded(
                      child: CtaButton(
                        text: 'Continue Exploring',
                        onPressed: () {
                          context.push('/experiences');
                        },
                        isPrimary: false,
                        customBackgroundColor:
                            const Color(0xFFF3F4F6), // Set background color
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Go to Home Button
                    Expanded(
                      child: CtaButton(
                        text: 'Go to Home',
                        onPressed: () {
                          context.push('/HomeScreen');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== SECTION TITLE ====================

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Instrument Sans',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
          height: 1.4,
        ),
      ),
    );
  }

  // ==================== BOOKING SUMMARY CARD ====================

  Widget _buildBookingSummaryCard() {
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
        // Changed from Row to Column
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to start
        children: [
          // Booking Summary Title
          _buildSectionTitle('Booking Summary'), // Moved here
          const SizedBox(height: 12), // Spacing after title
          Row(
            // Original content of the card
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/Bookings/experience/paris_walking.png',
                  width: 80,
                  height: 80,
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
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Explore the creative heart of Paris with a local guide',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Booking ID: 2025-3547',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==================== CONFIRMATION DETAILS CARD ====================

  Widget _buildConfirmationDetailsCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to start
        children: [
          // Confirmation Details Title
          _buildSectionTitle('Confirmation Details'), // Moved here
          const SizedBox(height: 12), // Spacing after title
          _buildDetailRow('Confirmation Number:', 'CNF-733085410'),
          const SizedBox(height: 12),
          _buildDetailRow('Confirmation Sent To:', 'benadeyemi@email.com'),
        ],
      ),
    );
  }

  // ==================== ACTIVITY DETAILS CARD ====================

  Widget _buildActivityDetailsCard(int travelers) {
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to start
        children: [
          // Activity Details Title
          _buildSectionTitle('Activity Details'), // Moved here
          const SizedBox(height: 12), // Spacing after title
          _buildIconRow(Icons.calendar_today_outlined, 'Date', 'Sept 25, 2025'),
          const SizedBox(height: 12),
          _buildIconRow(Icons.access_time, 'Time', '10:00 AM – 12:30 PM'),
          const SizedBox(height: 12),
          _buildIconRow(Icons.people_outline, 'Participants',
              '$travelers traveler${travelers > 1 ? 's' : ''}'),
          const SizedBox(height: 12),
          _buildIconRow(Icons.location_on_outlined, 'Meeting Point',
              'Montmartre District, Paris'),
        ],
      ),
    );
  }

  // ==================== PRICING BREAKDOWN CARD ====================

  Widget _buildPricingBreakdownCard(
      double basePrice, int travelers, double serviceFee, double total) {
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to start
        children: [
          // Pricing Breakdown Title
          _buildSectionTitle('Pricing Breakdown'),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '\$45 x 1 person',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const Text(
                '\$45',
                style: TextStyle(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Service fee',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              const Text(
                '\$0',
                style: TextStyle(
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
          Container(
            height: 1,
            color: const Color(0xFFF3F4F6),
          ),
          const SizedBox(height: 12),
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
              const Text(
                '\$45',
                style: TextStyle(
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

  // ==================== WHAT'S NEXT CARD ====================

  Widget _buildWhatsNextCard() {
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
        children: [
          _buildBulletPoint(
              'Check your email for meeting point details.', 0), // Pass index 0
          const SizedBox(height: 12),
          _buildBulletPoint(
              'Arrive 15 minutes before tour start time.', 1), // Pass index 1
          const SizedBox(height: 12),
          _buildBulletPoint(
              'Bring confirmation number and valid ID.', 2), // Pass index 2
        ],
      ),
    );
  }

  // ==================== HELPER WIDGETS ====================

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildIconRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF6B7280),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text, int index) {
    // Added index parameter
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFF3B82F6),
            shape: BoxShape.circle,
          ),
          child: Center(
            // Wrap Text in Center to align
            child: Text(
              '${index + 1}', // Display index + 1
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w600, // Make number bold
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111827),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // ==================== ACTION METHODS ====================

  void _downloadBooking() {
    print('Download booking');
    // Implement download functionality
  }

  void _shareBooking() {
    print('Share booking');
    // Implement share functionality
  }
}
