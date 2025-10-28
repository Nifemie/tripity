import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== BOOKING DETAILS PROVIDERS ====================

// Selected date provider
final selectedDateProvider = StateProvider<DateTime?>((ref) => null);

// Selected time slot provider
final selectedTimeSlotProvider = StateProvider<String?>((ref) => null);

// Number of travelers provider
final numberOfTravelersProvider = StateProvider<int>((ref) => 1);

// Base price per person (can be passed from experience details)
final basePricePerPersonProvider = StateProvider<double>((ref) => 45.0);

// Service fee percentage or fixed amount
final serviceFeeProvider = StateProvider<double>((ref) => 0.0);

// Calculated total price based on travelers and fees
final totalPriceProvider = Provider<double>((ref) {
  final travelers = ref.watch(numberOfTravelersProvider);
  final basePrice = ref.watch(basePricePerPersonProvider);
  final serviceFee = ref.watch(serviceFeeProvider);

  return (basePrice * travelers) + serviceFee;
});

// Current booking step (1-3)
final bookingStepProvider = StateProvider<int>((ref) => 1);

// Time slots available for booking
final availableTimeSlotsProvider = Provider<List<String>>((ref) {
  return [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
  ];
});

// Validation: Check if all required fields are filled
final isBookingDetailsValidProvider = Provider<bool>((ref) {
  final date = ref.watch(selectedDateProvider);
  final time = ref.watch(selectedTimeSlotProvider);
  final travelers = ref.watch(numberOfTravelersProvider);

  return date != null && time != null && travelers > 0;
});
