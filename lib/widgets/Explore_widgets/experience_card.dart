import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/events_design_constants.dart';
import '../../views/Explore_screen/destination_screens/tabs/experience.dart'; // For Experience model

// Individual Experience Card
class ExperienceCard extends StatelessWidget {
  final Experience experience;

  const ExperienceCard({
    super.key,
    required this.experience,
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
                image: AssetImage(experience.imageUrl),
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
                        experience.title,
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
                          experience.rating.toString(),
                          style: EventsTextStyles.caption,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Description
                Text(
                  experience.description,
                  style: EventsTextStyles.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // Experience Details Row
                Row(
                  children: [
                    // Time icon and text
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: EventsColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      experience.time,
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
                      experience.location,
                      style: EventsTextStyles.caption,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Price Row
                RichText(
                  text: TextSpan(
                    text: experience.price,
                    style: EventsTextStyles.priceText,
                    children: experience.priceLabel.isNotEmpty
                        ? [
                      TextSpan(
                        text: experience.priceLabel,
                        style: EventsTextStyles.caption,
                      ),
                    ]
                        : [],
                  ),
                ),
                const SizedBox(height: 16),
                // View & Book Button (Full Width)
                if (experience.hasViewBookButton)
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