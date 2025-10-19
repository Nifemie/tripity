import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== MODELS ====================

class EventCard {
  final String id;
  final String title;
  final String description;
  final String location;
  final String time;
  final String category; // e.g., "Fashion", "Music", "Sports"
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final double pricePerTicket;
  final String additionalInfo;
  final String imageUrl;
  final VoidCallback? onTap;

  const EventCard({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.pricePerTicket,
    required this.additionalInfo,
    required this.imageUrl,
    this.onTap,
  });
}

// ==================== RIVERPOD PROVIDERS ====================

// Provider for selected event
final selectedEventProvider = StateProvider<String?>((ref) => null);

// Provider for favorite events
final favoriteEventsProvider = StateProvider<Set<String>>((ref) => {});

// Provider for events list
final eventsProvider = Provider<List<EventCard>>((ref) {
  return [
    EventCard(
      id: 'event_1',
      title: 'Paris Fashion Week',
      description:
          'International fashion\'s newest trend showcasing haute couture',
      location: 'Grand Palais, Paris',
      time: 'Sep 2-10, 2025',
      category: 'Fashion',
      rating: 4.8,
      reviewCount: 2345,
      tags: ['Fashion', 'Runway', 'Designer'],
      pricePerTicket: 350.0,
      additionalInfo:
          'Includes runway access, welcome drink & concierge support',
      imageUrl: 'assets/images/Bookings/events/fashion_week.png',
    ),
  ];
});

// ==================== EVENT INFO SECTION ====================

class EventInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String time;
  final String category;
  final double rating;
  final int reviewCount;

  const EventInfoSection({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.time,
    required this.category,
    required this.rating,
    required this.reviewCount,
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
                const Icon(Icons.star, size: 14, color: Color(0xFFFCD34D)),
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

        // Location, Time, and Category Row
        Row(
          children: [
            // Location Icon
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Color(0xFF6B7280),
            ),
            const SizedBox(width: 6),

            // Location Text
            Flexible(
              child: Text(
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
            ),

            // Vertical Divider
            const SizedBox(width: 12),
            Container(width: 1, height: 16, color: const Color(0xFFE5E7EB)),
            const SizedBox(width: 12),

            // Time Icon
            const Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: Color(0xFF6B7280),
            ),
            const SizedBox(width: 6),

            // Time Text
            Text(
              time,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),

            // Vertical Divider
            const SizedBox(width: 12),
            Container(width: 1, height: 16, color: const Color(0xFFE5E7EB)),
            const SizedBox(width: 12),

            // Category Text
            Text(
              category,
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
    );
  }
}

// ==================== TAGS ROW ====================

class EventTagsRow extends StatelessWidget {
  final List<String> tags;

  const EventTagsRow({Key? key, required this.tags}) : super(key: key);

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
            color: Colors.white,
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

class EventPriceSection extends StatelessWidget {
  final double pricePerTicket;
  final String additionalInfo;

  const EventPriceSection({
    Key? key,
    required this.pricePerTicket,
    required this.additionalInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price Row
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'From \$${pricePerTicket.toStringAsFixed(0)}',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
                height: 1.5,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              '/ticket',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Additional Info
        Text(
          additionalInfo,
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
