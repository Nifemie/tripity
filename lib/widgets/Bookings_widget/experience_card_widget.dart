import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ==================== MODELS ====================

class ExperienceCard {
  final String id;
  final String title;
  final String description;
  final String location;
  final String duration;
  final String category; // e.g., "Audio Guide", "Tourism", "Culture"
  final double rating;
  final int reviewCount;
  final List<String> tags;
  final double pricePerPerson;
  final String imageUrl;
  final VoidCallback? onTap;

  const ExperienceCard({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
    required this.category,
    required this.rating,
    required this.reviewCount,
    required this.tags,
    required this.pricePerPerson,
    required this.imageUrl,
    this.onTap,
  });
}

// ==================== RIVERPOD PROVIDERS ====================

// Provider for selected experience
final selectedExperienceProvider = StateProvider<String?>((ref) => null);

// Provider for favorite experiences
final favoriteExperiencesProvider = StateProvider<Set<String>>((ref) => {});

// Provider for experiences list
final experiencesProvider = Provider<List<ExperienceCard>>((ref) {
  return [
    ExperienceCard(
      id: 'exp_1',
      title: 'Paris Walking Tour',
      description: 'Guided walking tour through historic Paris',
      location: 'Paris, France',
      duration: '2.5 hours',
      category: 'Audio Guide',
      rating: 4.7,
      reviewCount: 1245,
      tags: ['Guided Tour', 'Historical', 'Photography'],
      pricePerPerson: 45.0,
      imageUrl: 'assets/images/Bookings/experience/paris_walking.png',
    ),
    ExperienceCard(
      id: 'exp_2',
      title: 'Eiffel Tower Experience',
      description: 'Skip-the-line access to Eiffel Tower',
      location: 'Paris, France',
      duration: '3 hours',
      category: 'Tourism',
      rating: 4.8,
      reviewCount: 2156,
      tags: ['Skip-the-line', 'Iconic', 'Photo Ops'],
      pricePerPerson: 75.0,
      imageUrl: 'assets/images/Bookings/experience/palace_day.png',
    ),
    ExperienceCard(
      id: 'exp_3',
      title: 'Louvre Museum Tour',
      description: 'Expert-guided tour of world-famous art',
      location: 'Paris, France',
      duration: '4 hours',
      category: 'Culture',
      rating: 4.9,
      reviewCount: 3421,
      tags: ['Art', 'History', 'Expert Guide'],
      pricePerPerson: 89.0,
      imageUrl: 'assets/images/Bookings/experience/Tokyo_field.png',
    ),
    ExperienceCard(
      id: 'exp_4',
      title: 'Seine River Cruise',
      description: 'Romantic evening cruise with dinner',
      location: 'Paris, France',
      duration: '2 hours',
      category: 'Tourism',
      rating: 4.6,
      reviewCount: 987,
      tags: ['Dinner', 'Romance', 'Scenic'],
      pricePerPerson: 95.0,
      imageUrl: 'assets/images/Bookings/experience/Louvre.png',
    ),
  ];
});

// ==================== EXPERIENCE INFO SECTION ====================

class ExperienceInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final String location;
  final String duration;
  final String category;
  final double rating;
  final int reviewCount;

  const ExperienceInfoSection({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.duration,
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

        // Location, Duration, and Category Row
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

            // Duration Icon
            const Icon(Icons.access_time, size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),

            // Duration Text
            Text(
              duration,
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

class ExperienceTagsRow extends StatelessWidget {
  final List<String> tags;

  const ExperienceTagsRow({Key? key, required this.tags}) : super(key: key);

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

class ExperiencePriceSection extends StatelessWidget {
  final double pricePerPerson;

  const ExperiencePriceSection({Key? key, required this.pricePerPerson})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          'From \$${pricePerPerson.toStringAsFixed(0)}',
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
          '/person',
          style: TextStyle(
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
