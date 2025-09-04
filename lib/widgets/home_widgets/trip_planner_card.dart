import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart';

class TripPlannerCard extends StatelessWidget {
  final TripPlanner planner;

  const TripPlannerCard({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image - Updated styling
              Container(
                width: 44, // width: 44px
                height: 44, // height: 44px
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                  // border-radius: 44px
                  color: Colors.grey[300], // placeholder background
                  // You can replace this with:
                  // image: planner.imagePath != null
                  //   ? DecorationImage(
                  //       image: AssetImage(planner.imagePath!),
                  //       fit: BoxFit.cover,
                  //     )
                  //   : null,
                ),
                child: planner.imagePath == null
                    ? Icon(Icons.person, color: Colors.grey[600], size: 24)
                    : null,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Verified Badge
                    Row(
                      children: [
                        Text(
                          planner.name,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                            height: 1.5,
                          ),
                        ),
                        if (planner.isVerified) ...[
                          const SizedBox(width: 4),
                          // Blue verification icon - you'll add your SVG here
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              // Placeholder - replace with your blue verify SVG
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Rating and Reviews
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          planner.rating.toString(),
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${planner.reviews} Reviews)',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on,
                            color: Color(0xFF6B7280), size: 16),
                        const SizedBox(width: 4),
                        Text(
                          planner.location,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Specialties
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: planner.specialties
                          .map((specialty) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: const Color(0xFFF3F4F6),
                                ),
                                child: Text(
                                  specialty,
                                  style: const TextStyle(
                                    fontFamily: 'Instrument Sans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF374151),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),

                    const SizedBox(height: 8),

                    // Trip Stats and Accepting Clients
                    Row(
                      children: [
                        Text(
                          '${planner.tripsPlanned} trips planned',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Responds in ${planner.responseTime}',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Accepting Clients Badge - Updated styling
                    if (planner.isAcceptingClients)
                      Container(
                        padding: const EdgeInsets.all(4), // padding: 4px
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          // border-radius: var(--Border-Radius-full, 9999px)
                          color: const Color(
                              0xFFDCFCE7), // background: var(--Success-Green-100, #DCFCE7)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Green verification icon - you'll add your SVG here
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                // Placeholder - replace with your green verify SVG
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // gap: 8px
                            const Text(
                              'Accepting Clients',
                              style: TextStyle(
                                color: Color(0xFF22C55E),
                                // color: var(--Success-Green-500, #22C55E)
                                fontFamily: 'Instrument Sans',
                                // font-family: var(--Font-Primary, "Instrument Sans")
                                fontSize: 12,
                                // font-size: var(--Font-Size-xs, 12px)
                                fontWeight: FontWeight.w400,
                                // font-weight: var(--Font-Weight-normal, 400)
                                height: 1.5, // line-height: 18px (150%)
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom row with price aligned to the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\$${planner.price} per trip',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
