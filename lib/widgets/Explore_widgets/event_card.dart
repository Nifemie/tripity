import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/events_design_constants.dart';
import '../../views/Explore_screen/destination_screens/tabs/events.dart'; // For Event model

// Individual Event Card
class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: EventsColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              image: DecorationImage(
                image: AssetImage(event.imageUrl),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Fallback for missing images
                },
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Container
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: EventsTextStyles.heading6,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: EventsColors.warning400,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          event.rating.toString(),
                          style: EventsTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Description
                Text(
                  event.description,
                  style: EventsTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // Event Details Row
                Row(
                  children: [
                    // Date icon and text
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: EventsColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.date,
                      style: EventsTextStyles.caption,
                    ),
                    const SizedBox(width: 16),
                    // Location icon and text
                    Icon(
                      Icons.category_outlined,
                      size: 14,
                      color: EventsColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.location,
                      style: EventsTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Price Row
                RichText(
                  text: TextSpan(
                    text: event.price,
                    style: EventsTextStyles.priceText,
                    children: event.priceLabel.isNotEmpty
                        ? [
                      TextSpan(
                        text: event.priceLabel,
                        style: EventsTextStyles.caption,
                      ),
                    ]
                        : [],
                  ),
                ),
                const SizedBox(height: 16),
                // View & Book Button (Full Width)
                if (event.hasViewBookButton)
                  SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: () {
                        // Handle View & Book tap
                      },
                      child: Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          color: EventsColors.neutralGray100,
                        ),
                        child: const Center(
                          child: Text(
                            'View & Book',
                            style: EventsTextStyles.buttonText,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}