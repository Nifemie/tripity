import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;
import 'package:tripitify/widgets/Bookings_widget/booking_footer.dart';

// ==================== FAVORITE & BOOKMARK PROVIDERS ====================

final isFavoriteHotelProvider = StateProvider<bool>((ref) => false);
final isBookmarkedHotelProvider = StateProvider<bool>((ref) => false);

// ==================== REVIEW MODEL ====================

class HotelReview {
  final String reviewerName;
  final int rating;
  final String reviewText;
  final String avatar;

  HotelReview({
    required this.reviewerName,
    required this.rating,
    required this.reviewText,
    required this.avatar,
  });
}

// ==================== REVIEWS PROVIDER ====================

final hotelReviewsProvider = Provider<List<HotelReview>>((ref) {
  return [
    HotelReview(
      reviewerName: 'Emma W.',
      rating: 5,
      reviewText:
          'Absolutely stunning hotel with incredible service. The afternoon tea was a highlight of our London trip!',
      avatar: 'M',
    ),
    HotelReview(
      reviewerName: 'David K.',
      rating: 5,
      reviewText:
          'Perfect location and the staff went above and beyond. Will definitely stay here again',
      avatar: 'M',
    ),
  ];
});

// ==================== HOTEL DETAILS PAGE ====================

class StaysDetailsPage extends ConsumerWidget {
  const StaysDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(isFavoriteHotelProvider);
    final isBookmarked = ref.watch(isBookmarkedHotelProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image with Overlay
                _buildHeroImage(context, ref, isFavorite, isBookmarked),

                // Content Section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hotel Information
                      _buildHotelInfo(),
                      const SizedBox(height: 24),

                      // Photo Gallery
                      _buildPhotoGallery(),
                      const SizedBox(height: 24),

                      // Amenities
                      _buildAmenities(),
                      const SizedBox(height: 24),

                      // Highlights
                      _buildHighlights(),
                      const SizedBox(height: 24),

                      // Important Information
                      _buildImportantInfo(),
                      const SizedBox(height: 24),

                      // Recent Reviews
                      _buildRecentReviews(ref),
                      const SizedBox(height: 100), // Space for footer
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Booking Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BookingFooter(
              pricePerPerson: 650.0,
              priceLabel: 'night',
              onBookNow: () {
                final quantity = ref.read(bookingQuantityProvider);
                print('Booking for $quantity nights');
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hero Image with Overlay Controls
  Widget _buildHeroImage(
    BuildContext context,
    WidgetRef ref,
    bool isFavorite,
    bool isBookmarked,
  ) {
    return Stack(
      children: [
        // Image
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.asset(
            'assets/images/Bookings/stays/RITZ.png',
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
                  const Color(0xFF000000).withOpacity(0.3),
                  const Color(0xFF000000).withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),

        // Top Controls
        Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10998.9),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(8.8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10998.9),
                        color: const Color(0xFF000000).withOpacity(0.24),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // Favorite and Bookmark Buttons
              Row(
                children: [
                  // Favorite Button
                  GestureDetector(
                    onTap: () {
                      ref.read(isFavoriteHotelProvider.notifier).state =
                          !isFavorite;
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10998.9),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                        child: Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(8.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10998.9),
                            color: const Color(0xFF000000).withOpacity(0.24),
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color:
                                isFavorite
                                    ? const Color(0xFFEF4444)
                                    : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Bookmark Button
                  GestureDetector(
                    onTap: () {
                      ref.read(isBookmarkedHotelProvider.notifier).state =
                          !isBookmarked;
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10998.9),
                      child: BackdropFilter(
                        filter: ui.ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                        child: Container(
                          width: 44,
                          height: 44,
                          padding: const EdgeInsets.all(8.8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10998.9),
                            color: const Color(0xFF000000).withOpacity(0.24),
                          ),
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color:
                                isBookmarked
                                    ? const Color(0xFF3B82F6)
                                    : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Hotel Information
  Widget _buildHotelInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'The Ritz London',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Luxury Hotel in Piccadilly',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Rating
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/Bookings/Star.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '4.5',
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
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'by Ritz Hotels',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Experience timeless luxury at The Ritz London. Located in the heart of Piccadilly, enjoy world-class service, award-winning restaurants, and proximity to London\'s finest attractions.',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // Photo Gallery
  Widget _buildPhotoGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photos',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/Bookings/stays/RITZ.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/Bookings/stays/RITZ.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/Bookings/stays/RITZ.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Amenities
  Widget _buildAmenities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Amenities',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildAmenityItem(Icons.wifi, 'Free WiFi'),
            Container(width: 1, height: 20, color: const Color(0xFFE5E7EB)),
            _buildAmenityItem(Icons.local_parking, 'Valet Parking'),
            Container(width: 1, height: 20, color: const Color(0xFFE5E7EB)),
            _buildAmenityItem(Icons.room_service, '24/7 Room Service'),
            _buildAmenityItem(Icons.fitness_center, 'Fitness Center'),
          ],
        ),
      ],
    );
  }

  Widget _buildAmenityItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: const Color(0xFF6B7280)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Highlights
  Widget _buildHighlights() {
    final highlights = [
      'Prime Piccadilly location',
      'Michelin-starred dining',
      'Luxury spa facilities',
      'Concierge services',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Highlights',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              highlights.map((highlight) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFFF3F4F6),
                  ),
                  child: Text(
                    highlight,
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  // Important Information
  Widget _buildImportantInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Important Information',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Check-in:', '3:00 PM'),
        const SizedBox(height: 8),
        _buildInfoRow('Check-out:', '11:00 AM'),
        const SizedBox(height: 8),
        _buildInfoRow(
          'Cancellation:',
          'Free cancellation until 24 hours before check-in',
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF111827),
              height: 1.5,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // Recent Reviews
  Widget _buildRecentReviews(WidgetRef ref) {
    final reviews = ref.watch(hotelReviewsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Reviews',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 12),
        ...reviews.map(
          (review) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildReviewCard(review),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            print('View more reviews');
          },
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: const Color(0xFFF3F4F6),
            ),
            child: const Center(
              child: Text(
                'View More',
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
      ],
    );
  }

  Widget _buildReviewCard(HotelReview review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF3F4F6),
                ),
                child: Center(
                  child: Text(
                    review.avatar,
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.5,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: Icon(
                            index < review.rating
                                ? Icons.star
                                : Icons.star_border,
                            size: 14,
                            color: const Color(0xFFFBBC04),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review.reviewText,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
