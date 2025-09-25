import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../widgets/Explore_widgets/experience_card.dart';
import '../../../../core/constants/events_design_constants.dart';

// Models
class Experience {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String priceLabel;
  final String time;
  final String location;
  final double rating;
  final bool isFreeEvent;
  final bool hasViewBookButton;

  const Experience({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.priceLabel,
    required this.time,
    required this.location,
    required this.rating,
    this.isFreeEvent = false,
    this.hasViewBookButton = true,
  });
}

// Providers
final experienceProvider = Provider<List<Experience>>((ref) {
  return [
    const Experience(
      title: 'Seine River Dinner Cruise',
      description: 'Romantic dinner cruise with city views',
      imageUrl: 'assets/images/explore/Seine.png',
      price: '\$350',
      priceLabel: '/person',
      time: '2.5 hours',
      location: 'Fashion',
      rating: 4.8,
    ),
    const Experience(
      title: 'Paris Walking Tour',
      description: 'Explore the artistic heart of Paris with a local guide',
      imageUrl: 'assets/images/explore/montmartre.png',
      price: '\$30',
      priceLabel: '/person',
      time: '2.5 hours',
      location: 'Art',
      rating: 4.7,
      isFreeEvent: false,
      hasViewBookButton: true,
    ),
    const Experience(
      title: 'Montmartre Art Walk',
      description: 'Guided tour of historic artist quarter',
      imageUrl: 'assets/images/explore/walking_tour.png',
      price: '\$78',
      priceLabel: '/ticket',
      time: '3 hours',
      location: 'Food & Drink',
      rating: 4.6,
    ),
  ];
});

// Main Events Widget
class ExperienceWidget extends ConsumerWidget {
  const ExperienceWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(experienceProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: events.length + 1, // +1 for the header
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header Row
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Unique Experiences',
                  style: EventsTextStyles.heading5,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle View All tap for Experiences
                  },
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: EventsColors.neutralGray100,
                    ),
                    child: const Center(
                      child: Text(
                        'View All',
                        style: EventsTextStyles.viewAllText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          // Event Cards
          final event = events[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ExperienceCard(experience: event),
          );
        }
      },
    );
  }
}