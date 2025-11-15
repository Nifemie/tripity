import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/wishlist_widgets/wishlist_destination_card.dart';
import '../../widgets/wishlist_widgets/wishlist_booking_card.dart';

// Tab enum
enum WishlistTab { all, destinations, bookings }

// Wishlist state provider
final wishlistTabProvider =
    StateProvider<WishlistTab>((ref) => WishlistTab.all);

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(wishlistTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTab(
                    context,
                    ref,
                    'All',
                    WishlistTab.all,
                    selectedTab,
                    2,
                  ),
                  const SizedBox(width: 12),
                  _buildTab(
                    context,
                    ref,
                    'Destinations',
                    WishlistTab.destinations,
                    selectedTab,
                    1,
                  ),
                  const SizedBox(width: 12),
                  _buildTab(
                    context,
                    ref,
                    'Bookings',
                    WishlistTab.bookings,
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
    WishlistTab tab,
    WishlistTab selectedTab,
    int count,
  ) {
    final isSelected = selectedTab == tab;

    return GestureDetector(
      onTap: () {
        ref.read(wishlistTabProvider.notifier).state = tab;
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
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF6B7280),
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

  Widget _buildContent(WishlistTab selectedTab) {
    switch (selectedTab) {
      case WishlistTab.all:
        return Column(
          children: [
            _buildDestinationCard(),
            _buildBookingCard(),
          ],
        );
      case WishlistTab.destinations:
        return _buildDestinationCard();
      case WishlistTab.bookings:
        return _buildBookingCard();
    }
  }

  Widget _buildDestinationCard() {
    return WishlistDestinationCard(
      imageUrl: 'assets/images/explore/USA.png',
      title: 'New York City, USA',
      description:
          'The city that never sleeps with iconic landmarks and vibrant cult...',
      rating: '4.5',
      travellersCount: '24',
      tags: ['Culture', 'Food & Cuisine', 'Photography', 'Shopping'],
      isFavorite: true,
      onFavoriteToggle: () {
        // Handle favorite toggle
      },
      onPlanTrip: () {
        // Handle plan trip
      },
      onShare: () {
        // Handle share
      },
      onDelete: () {
        // Handle delete
      },
    );
  }

  Widget _buildBookingCard() {
    return WishlistBookingCard(
      imageUrl: 'assets/images/explore/walking_tour.png',
      title: 'Paris Walking Tour',
      description: 'Explore the artistic heart of Paris with a local guide',
      rating: '4.7',
      location: 'Paris, France',
      duration: '2.5 hours',
      category: 'Tourism',
      features: [
        'Audio Guide',
        'Palace Access',
        'Skip-the-Line',
        'Photo Stops'
      ],
      price: '\$45 /person',
      isFavorite: true,
      onFavoriteToggle: () {
        // Handle favorite toggle
      },
      onAddToTrip: () {
        // Handle add to trip
      },
      onShare: () {
        // Handle share
      },
    );
  }
}
