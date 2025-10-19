import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui' as ui;

// ==================== MODELS ====================

class HotelCard {
  final String id;
  final String title;
  final String description;
  final String location;
  final int reviewCount;
  final double rating;
  final List<String> tags; // e.g., ['Luxury', 'Iconic Landmark', 'Spa Access']
  final double pricePerNight;
  final String imageUrl;
  final bool isTrending;
  final String? distance; // e.g., '0.3 km from Buckingham Palace'
  final VoidCallback? onTap;

  const HotelCard({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.reviewCount,
    required this.rating,
    required this.tags,
    required this.pricePerNight,
    required this.imageUrl,
    this.isTrending = false,
    this.distance,
    this.onTap,
  });
}

// ==================== RIVERPOD PROVIDERS ====================

// Provider for selected hotel
final selectedHotelProvider = StateProvider<String?>((ref) => null);

// Provider for favorite hotels
final favoriteHotelsProvider = StateProvider<Set<String>>((ref) => {});

// Provider for hotels list
final hotelsProvider = Provider<List<HotelCard>>((ref) {
  return [
    HotelCard(
      id: 'hotel_1',
      title: 'The Plaza New York',
      description: 'Luxury Hotel in Midtown Manhattan',
      location: 'Fifth Avenue, New York City',
      reviewCount: 3210,
      rating: 4.7,
      tags: ['Luxury', 'Iconic Landmark', 'Spa Access', '+3'],
      pricePerNight: 720.0,
      imageUrl: 'assets/images/Bookings/Plazza.png',
      isTrending: true,
      // No distance in base provider - will be added only in stays.dart
    ),
    HotelCard(
      id: 'hotel_2',
      title: 'The Peninsula New York',
      description: 'Luxury Hotel in Midtown Manhattan',
      location: 'Fifth Avenue, New York City',
      reviewCount: 2890,
      rating: 4.6,
      tags: ['Luxury', 'Fine Dining', 'Concierge', '+2'],
      pricePerNight: 650.0,
      imageUrl: 'assets/images/Bookings/The_plazzion.png',
      isTrending: true,
      // No distance in base provider - will be added only in stays.dart
    ),
  ];
});

// ==================== HOTEL IMAGE WITH OVERLAY ====================

class HotelImageOverlay extends ConsumerWidget {
  final String imageUrl;
  final bool isTrending;
  final String hotelId;

  const HotelImageOverlay({
    Key? key,
    required this.imageUrl,
    required this.isTrending,
    required this.hotelId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteHotels = ref.watch(favoriteHotelsProvider);
    final isFavorite = favoriteHotels.contains(hotelId);

    return Stack(
      children: [
        // Hotel Image
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Overlay with blur
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF000000).withOpacity(0.2),
                  const Color(0xFF000000).withOpacity(0.0),
                ],
              ),
            ),
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0),
              child: Container(),
            ),
          ),
        ),

        // Top Row: Trending Badge (Left) and Heart Icon (Right)
        Positioned(
          top: 12,
          left: 12,
          right: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Trending Badge
              if (isTrending)
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/explore/Fire.svg',
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Trending',
                            style: TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              // Heart Icon Button
              GestureDetector(
                onTap: () {
                  final favorites = ref.read(favoriteHotelsProvider.notifier);
                  if (isFavorite) {
                    favorites.state = {...favoriteHotels}..remove(hotelId);
                  } else {
                    favorites.state = {...favoriteHotels, hotelId};
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF000000).withOpacity(0.24),
                      ),
                      child: Center(
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color:
                              isFavorite
                                  ? const Color(0xFFEF4444)
                                  : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ==================== HOTEL INFO SECTION ====================

class HotelInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final int reviewCount;
  final double rating;
  final String? distance;

  const HotelInfoSection({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.reviewCount,
    required this.rating,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title and Rating Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.33,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Rating Section
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/images/Bookings/Star.svg',
                  width: 14,
                  height: 14,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFFCD34D),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  rating.toString(),
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Description
        Text(
          description,
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.43,
          ),
        ),
        const SizedBox(height: 12),

        // Location and Reviews Row
        Row(
          children: [
            // Location Icon
            SvgPicture.asset(
              'assets/images/Bookings/location.svg',
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                Color(0xFF6B7280),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),

            // Location Text
            Text(
              location,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            // Vertical Divider
            const SizedBox(width: 12),
            Container(width: 1, height: 16, color: const Color(0xFFE5E7EB)),
            const SizedBox(width: 12),

            // Review Count
            SvgPicture.asset(
              'assets/images/Bookings/Dialog.svg',
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                Color(0xFF6B7280),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '($reviewCount)',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ],
        ),

        // Distance (if provided)
        if (distance != null) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 6),
              Text(
                distance!,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ==================== TAGS ROW ====================

class HotelTagsRow extends StatelessWidget {
  final List<String> tags;

  const HotelTagsRow({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(tags.length, (index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
            color: Color(0xffF3F4F6),
          ),
          child: Text(
            tags[index],
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        );
      }),
    );
  }
}

// ==================== PRICE SECTION ====================

class HotelPriceSection extends StatelessWidget {
  final double pricePerNight;

  const HotelPriceSection({Key? key, required this.pricePerNight})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'From \$${pricePerNight.toStringAsFixed(0)}',
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '/night',
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==================== HOTEL CARD WIDGET ====================

class HotelCard_Widget extends ConsumerWidget {
  final HotelCard hotel;

  const HotelCard_Widget({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(selectedHotelProvider.notifier).state = hotel.id;
        hotel.onTap?.call();
        print('Selected hotel: ${hotel.title}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hotel Image with Overlay
            HotelImageOverlay(
              imageUrl: hotel.imageUrl,
              isTrending: hotel.isTrending,
              hotelId: hotel.id,
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
              child: HotelPriceSection(pricePerNight: hotel.pricePerNight),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ==================== HOTEL CARDS HORIZONTAL SCROLL ====================

class HotelCardsScroll extends ConsumerWidget {
  const HotelCardsScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hotels = ref.watch(hotelsProvider);

    return Container(
      height: 450,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 16 : 0),
            child: HotelCard_Widget(hotel: hotels[index]),
          );
        },
      ),
    );
  }
}

// ==================== HOTEL SECTION ====================

class HotelSection extends ConsumerWidget {
  final String title;
  final String? subtitle;

  const HotelSection({Key? key, this.title = 'Popular Stays', this.subtitle})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.4,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Hotel Cards Scroll
        const HotelCardsScroll(),
      ],
    );
  }
}
