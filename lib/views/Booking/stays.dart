import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/Bookings_widget/Stays_tab.dart';
import '../../widgets/Bookings_widget/hotel_card_widget.dart';
import '../../widgets/Bookings_widget/custom_reusable_button.dart';
import 'package:flutter_svg/svg.dart';

// ==================== STAYS-SPECIFIC PROVIDER ====================

// Provider for hotels with distance information (only for stays page)
final staysHotelsProvider = Provider<List<HotelCard>>((ref) {
  return [
    HotelCard(
      id: 'hotel_1',
      title: 'The Ritz London',
      description: 'Luxury Hotel in Piccadilly',
      location: 'Piccadilly, Central London',
      reviewCount: 3210,
      rating: 4.7,
      tags: ['FreeWifi', 'Free fitness', 'vallet parking', '+3'],
      pricePerNight: 720.0,
      imageUrl: 'assets/images/Bookings/stays/RITZ.png',
      isTrending: true,
      distance: '0.3 km from Buckingham Palace',
    ),
    HotelCard(
      id: 'hotel_2',
      title: 'Tokyo Palace Hotel',
      description:
          'Warm, attentive service, comfortable and luxurious rooms, and s....',
      location: 'Chiyoda, Central Tokyo',
      reviewCount: 2890,
      rating: 4.6,
      tags: ['freeWifi', 'pool', 'SPA', '+2'],
      pricePerNight: 650.0,
      imageUrl: 'assets/images/Bookings/stays/Tokyo.png',
      isTrending: true,
      distance: '0.5 km from Central Park',
    ),
  ];
});

// ==================== STAYS PAGE ====================

class StaysPage extends ConsumerWidget {
  const StaysPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedStaysTabProvider);
    final hotels = ref.watch(
      staysHotelsProvider,
    ); // Use stays-specific provider

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // leadingWidth: 40,
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Stays',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.33,
          ),
        ),
        centerTitle: false,
        actions: [
          // Search Icon
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFF111827),
                size: 24,
              ),
              onPressed: () {
                // Handle search
              },
            ),
          ),
          // Filter Icon
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // Handle filter action
              },
              icon: SvgPicture.asset(
                'assets/images/Bookings/Transport/Tuning.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF6B7280),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // White background container for tabs
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Stays Tab Bar
                const StaysTabBar(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Hotel Cards based on selected tab
                  if (selectedTab == 'All' || selectedTab == 'Hotels')
                    _buildHotelCards(context, hotels),

                  // Placeholder for other stay types
                  if (selectedTab == 'Apartments')
                    _buildComingSoonSection('Apartments'),
                  if (selectedTab == 'Hostel')
                    _buildComingSoonSection('Hostels'),
                  if (selectedTab == 'Resort')
                    _buildComingSoonSection('Resorts'),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build hotel cards with buttons
  Widget _buildHotelCards(BuildContext context, List<HotelCard> hotels) {
    return Column(
      children:
          hotels.map((hotel) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF172554).withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hotel Image with Overlay (full width with top rounded corners)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          children: [
                            // Hotel Image - Full Width
                            Positioned.fill(
                              child: Image.asset(
                                hotel.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Gradient Overlay
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      const Color(0xFF000000).withOpacity(0.2),
                                      const Color(0xFF000000).withOpacity(0.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Trending Badge and Heart Icon
                            Positioned(
                              top: 12,
                              left: 12,
                              right: 12,
                              child: _buildImageOverlayControls(hotel),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Hotel Info Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: HotelInfoSection(
                        title: hotel.title,
                        description: hotel.description,
                        location: hotel.location,
                        reviewCount: hotel.reviewCount,
                        rating: hotel.rating,
                        distance: hotel.distance,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tags Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: HotelTagsRow(tags: hotel.tags),
                    ),
                    const SizedBox(height: 16),

                    // Price Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: HotelPriceSection(
                        pricePerNight: hotel.pricePerNight,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Buttons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TransportButtonRow(
                        onViewDetails: () {
                          context.push('/stays-details');
                        },
                        onBookNow: () {
                          print('Book now for ${hotel.title}');
                          // Navigate to booking page
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  // Build image overlay controls (trending badge and heart icon)
  Widget _buildImageOverlayControls(HotelCard hotel) {
    return Consumer(
      builder: (context, ref, child) {
        final favoriteHotels = ref.watch(favoriteHotelsProvider);
        final isFavorite = favoriteHotels.contains(hotel.id);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Trending Badge
            if (hotel.isTrending)
              ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFF000000).withOpacity(0.24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.local_fire_department,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'In demand',
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Heart Icon Button
            GestureDetector(
              onTap: () {
                final favorites = ref.read(favoriteHotelsProvider.notifier);
                if (isFavorite) {
                  favorites.state = {...favoriteHotels}..remove(hotel.id);
                } else {
                  favorites.state = {...favoriteHotels, hotel.id};
                }
              },
              child: Container(
                width: 40,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF3F4F6),
                ),
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 20,
                  color:
                      isFavorite
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF9CA3AF),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Coming soon section for other stay types
  Widget _buildComingSoonSection(String stayType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFEFF6FF),
              ),
              child: const Icon(
                Icons.hotel_outlined,
                size: 40,
                color: Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$stayType Coming Soon',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
                height: 1.33,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We\'re working on bringing you the best $stayType options',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
