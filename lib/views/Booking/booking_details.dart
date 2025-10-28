import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/providers/booking_providers.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/Bookings_widget/Bookings_cta_button.dart';

// ==================== BOOKING DETAILS PAGE ====================

class BookingDetailsPage extends ConsumerWidget {
  const BookingDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    final selectedTime = ref.watch(selectedTimeSlotProvider);
    final numberOfTravelers = ref.watch(numberOfTravelersProvider);
    final basePrice = ref.watch(basePricePerPersonProvider);
    final serviceFee = ref.watch(serviceFeeProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final isValid = ref.watch(isBookingDetailsValidProvider);
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
            ref.read(bookingStepProvider.notifier).state = 1;
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Booking Details',
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
                    // Experience Summary Card
                    _buildExperienceCard(),
                    const SizedBox(height: 24),

                    // Date Field
                    _buildDateField(context, ref, selectedDate),
                    const SizedBox(height: 16),

                    // Time Selection Field
                    _buildTimeField(context, ref, selectedTime),
                    const SizedBox(height: 16),

                    // Number of Travelers
                    _buildTravelersCounter(ref, numberOfTravelers),
                    const SizedBox(height: 48),

                    // Booking Summary
                    _buildBookingSummary(
                      basePrice,
                      serviceFee,
                      totalPrice,
                      numberOfTravelers,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom CTA Button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFF3F4F6), width: 1),
              ),
            ),
            child: SafeArea(
              child: CtaButton(
                text: 'Continue to Personal Details',
                onPressed: () {
                  // Navigate to personal details page
                  _continueToPersonalDetails(context, ref);
                },
                isEnabled: isValid,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== EXPERIENCE SUMMARY CARD ====================

  Widget _buildExperienceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFEFF6FF),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Experience Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/Bookings/experience/paris_walking.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

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
                  'Explore the artistic heart of Paris with a local guide',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'by Paris Walking Tours',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 10,
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
    );
  }

  // ==================== DATE FIELD ====================

  Widget _buildDateField(
    BuildContext context,
    WidgetRef ref,
    DateTime? selectedDate,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context, ref),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
              color: const Color(0xFFF9FAFB),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? _formatDate(selectedDate)
                        : 'Select date',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          selectedDate != null
                              ? const Color(0xFF111827)
                              : const Color(0xFF9CA3AF),
                      height: 1.5,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 20,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== TIME FIELD ====================

  Widget _buildTimeField(
    BuildContext context,
    WidgetRef ref,
    String? selectedTime,
  ) {
    final timeSlots = ref.watch(availableTimeSlotsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Time',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showTimeSlotPicker(context, ref, timeSlots),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
              color: const Color(0xFFF9FAFB),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime ?? 'Choose time slot',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color:
                          selectedTime != null
                              ? const Color(0xFF111827)
                              : const Color(0xFF9CA3AF),
                      height: 1.5,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Color(0xFF6B7280),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==================== TRAVELERS COUNTER ====================

  Widget _buildTravelersCounter(WidgetRef ref, int numberOfTravelers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Travelers',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // Minus Button
            GestureDetector(
              onTap: () {
                if (numberOfTravelers > 1) {
                  ref.read(numberOfTravelersProvider.notifier).state =
                      numberOfTravelers - 1;
                }
              },
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF3F4F6),
                ),
                child: const Center(
                  child: Icon(Icons.remove, size: 20, color: Color(0xFF111827)),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Count Display
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // Removed background color
              ),
              child: Center(
                child: Text(
                  '$numberOfTravelers',
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Plus Button
            GestureDetector(
              onTap: () {
                if (numberOfTravelers < 15) {
                  ref.read(numberOfTravelersProvider.notifier).state =
                      numberOfTravelers + 1;
                }
              },
              child: Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF3F4F6),
                ),
                child: const Center(
                  child: Icon(Icons.add, size: 20, color: Color(0xFF111827)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==================== BOOKING SUMMARY ====================

  Widget _buildBookingSummary(
    double basePrice,
    double serviceFee,
    double totalPrice,
    int numberOfTravelers,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Booking Summary',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Base Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Base price (per person)',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
              Text(
                '\$${basePrice.toStringAsFixed(0)}',
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
                'Service fee',
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
          const SizedBox(height: 12),

          // Divider
          Container(height: 1, color: const Color(0xFFF3F4F6)),
          const SizedBox(height: 12),

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
                '\$${totalPrice.toStringAsFixed(0)}',
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

  // ==================== DATE PICKER ====================

  Future<void> _selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF3B82F6),
              onPrimary: Colors.white,
              onSurface: Color(0xFF111827),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
    }
  }

  // ==================== TIME SLOT PICKER ====================

  void _showTimeSlotPicker(
    BuildContext context,
    WidgetRef ref,
    List<String> timeSlots,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color(0xFFE5E7EB),
                  ),
                ),

                // Title
                const Text(
                  'Select Time Slot',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),

                // Time slots list
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: timeSlots.length,
                  separatorBuilder:
                      (context, index) =>
                          const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  itemBuilder: (context, index) {
                    final timeSlot = timeSlots[index];
                    return ListTile(
                      title: Text(
                        timeSlot,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),
                      onTap: () {
                        ref.read(selectedTimeSlotProvider.notifier).state =
                            timeSlot;
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==================== NAVIGATION ====================

  void _continueToPersonalDetails(BuildContext context, WidgetRef ref) {
    // Increment booking step
    ref.read(bookingStepProvider.notifier).state = 2;

    // Navigate to personal details page
    context.push('/personal-details');
  }

  // ==================== HELPER METHODS ====================

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }
}
