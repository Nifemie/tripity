import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart';

class TripPlannerCard extends StatelessWidget {
  final TripPlanner planner;

  const TripPlannerCard({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x17172554).withOpacity(0.08),
            offset: const Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              SizedBox(
                width: 44,
                height: 44,
                child: ClipOval(
                  child: planner.imagePath != null && planner.imagePath!.endsWith('.svg')
                      ? SvgPicture.asset(
                          planner.imagePath!,
                          fit: BoxFit.cover,
                        )
                      : planner.imagePath != null
                          ? Image.asset(
                              planner.imagePath!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.person, color: Colors.grey[600], size: 24),
                            ),
                ),
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
                          SvgPicture.asset(
                            'assets/images/Trips/Verified_Check.svg',
                            width: 16,
                            height: 16,
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
                        Flexible(
                          child: Text(
                            planner.location,
                            style: const TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                            overflow: TextOverflow.ellipsis,
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

                    // Trip Stats
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
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom row with Accepting Clients badge and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Accepting Clients Badge
              if (planner.isAcceptingClients)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFFDCFCE7),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Trips/Check_Circle.svg',
                        width: 12,
                        height: 12,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Accepting Clients',
                        style: TextStyle(
                          color: Color(0xFF22C55E),
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox.shrink(),

              // Price
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