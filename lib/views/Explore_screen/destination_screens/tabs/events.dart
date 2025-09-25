import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../widgets/Explore_widgets/event_card.dart';
import '../../../../core/constants/events_design_constants.dart';

// Models
class Event {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String priceLabel;
  final String date;
  final String location;
  final double rating;
  final bool isFreeEvent;
  final bool hasViewBookButton;

  const Event({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.priceLabel,
    required this.date,
    required this.location,
    required this.rating,
    this.isFreeEvent = false,
    this.hasViewBookButton = true,
  });
}

// Providers
final eventsProvider = Provider<List<Event>>((ref) {
  return [
    const Event(
      title: 'Paris Fashion Week',
      description: 'An international fashion event showcasing haute couture',
      imageUrl: 'assets/images/explore/fashion.png',
      price: '\$350',
      priceLabel: '/person',
      date: 'Oct 1-8, 2024',
      location: 'Fashion',
      rating: 4.8,
    ),
    const Event(
      title: 'Nuit Blanche',
      description: 'All-night arts festival across the city',
      imageUrl: 'assets/images/explore/nuit.png',
      price: 'Free Event',
      priceLabel: '',
      date: 'Oct 5, 2024',
      location: 'Art',
      rating: 4.7,
      isFreeEvent: true,
      hasViewBookButton: false,
    ),
    const Event(
      title: 'Wine Harvest Festival',
      description: 'Celebrate the wine harvest with tastings',
      imageUrl: 'assets/images/explore/whine.png',
      price: '\$78',
      priceLabel: '/ticket',
      date: 'Sep 22-29, 2024',
      location: 'Food & Drink',
      rating: 4.6,
    ),
  ];
});

// Main Events Widget
class EventsWidget extends ConsumerWidget {
  const EventsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);

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
                  'Events & Happenings',
                  style: EventsTextStyles.heading5,
                ),
                GestureDetector(
                  onTap: () {
                    // Handle View All tap
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
            child: EventCard(event: event),
          );
        }
      },
    );
  }
}