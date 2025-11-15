import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/booking_widgets/booking_card.dart';

// Tab enum
enum BookingTab { upcoming, past }

// Booking tab provider
final bookingTabProvider =
    StateProvider<BookingTab>((ref) => BookingTab.upcoming);

class MyBookingsScreen extends ConsumerWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(bookingTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'My Bookings',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab(
                    context,
                    ref,
                    'Upcoming',
                    BookingTab.upcoming,
                    selectedTab,
                    2,
                  ),
                  const SizedBox(width: 12),
                  _buildTab(
                    context,
                    ref,
                    'Past',
                    BookingTab.past,
                    selectedTab,
                    1,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildContent(selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    BookingTab tab,
    BookingTab selectedTab,
    int count,
  ) {
    final isSelected = selectedTab == tab;

    return GestureDetector(
      onTap: () {
        ref.read(bookingTabProvider.notifier).state = tab;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF111827)
                    : const Color(0xFF9CA3AF),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BookingTab selectedTab) {
    switch (selectedTab) {
      case BookingTab.upcoming:
        return Column(
          children: [
            _buildUpcomingHotelCard(),
            _buildUpcomingExperienceCard(),
          ],
        );
      case BookingTab.past:
        return Column(
          children: [
            _buildPastHotelCard(),
            _buildPastExperienceCard(),
          ],
        );
    }
  }

  Widget _buildUpcomingHotelCard() {
    return BookingCard(
      imageUrl: 'assets/images/Bookings/stays/RITZ.png',
      title: 'The Ritz London',
      subtitle: 'Luxury Hotel in Piccadilly',
      rating: '4.5',
      location: 'Piccadilly, Central London',
      reviews: '2,847 Reviews',
      distance: '0.3 km from Buckingham Palace',
      features: ['Free WiFi', 'Fitness Center', 'Valet Parking', 'Spa'],
      bookingReference: 'HTL-2025-001',
      totalPrice: '\$650',
      status: 'Confirmed',
      isUpcoming: true,
      onPrimaryAction: () {
        // Handle download
      },
      onSecondaryAction: () {
        // Handle contact
      },
    );
  }

  Widget _buildUpcomingExperienceCard() {
    return BookingCard(
      imageUrl: 'assets/images/Bookings/experience/Louvre.png',
      title: 'Louvre Museum Private Tour',
      subtitle:
          'Explore the world\'s most iconic art collection on a small-group t...',
      rating: '4.8',
      location: 'Paris, France',
      duration: '3 hours',
      category: 'Culture',
      features: ['Skip-the-line', 'Private Guide'],
      bookingReference: 'EXP-2025-001',
      totalPrice: '\$95',
      status: 'Confirmed',
      isUpcoming: true,
      onPrimaryAction: () {
        // Handle download
      },
      onSecondaryAction: () {
        // Handle contact
      },
    );
  }

  Widget _buildPastHotelCard() {
    return BookingCard(
      imageUrl: 'assets/images/Bookings/stays/RITZ.png',
      title: 'The Ritz London',
      subtitle: 'Luxury Hotel in Piccadilly',
      rating: '4.5',
      location: 'Piccadilly, Central London',
      reviews: '2,847 Reviews',
      distance: '0.3 km from Buckingham Palace',
      features: ['Free WiFi', 'Fitness Center', 'Valet Parking', 'Spa'],
      bookingReference: 'HTL-2025-001',
      totalPrice: '\$650',
      status: 'Completed',
      isUpcoming: false,
      onPrimaryAction: () {
        // Handle book now
      },
      onSecondaryAction: () {
        // Handle view details
      },
    );
  }

  Widget _buildPastExperienceCard() {
    return BookingCard(
      imageUrl: 'assets/images/Bookings/experience/Louvre.png',
      title: 'Louvre Museum Private Tour',
      subtitle:
          'Explore the world\'s most iconic art collection on a small-group t...',
      rating: '4.8',
      location: 'Paris, France',
      duration: '3 hours',
      category: 'Culture',
      features: ['Skip-the-line', 'Private Guide'],
      bookingReference: 'EXP-2025-001',
      totalPrice: '\$95',
      status: 'Completed',
      isUpcoming: false,
      onPrimaryAction: () {
        // Handle book now
      },
      onSecondaryAction: () {
        // Handle view details
      },
    );
  }
}
