import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart'; // Import TripPlanner model

class TripsPlannedScreen extends StatelessWidget {
  final TripPlanner planner; // Add planner parameter

  const TripsPlannedScreen({Key? key, required this.planner}) : super(key: key); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Header Text
            Text(
              'Trips ${planner.name} has planned', // Use planner.name
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF4B5563),
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Trip Cards
            // TODO: Replace hardcoded TripCard data with actual trips from planner object
            // This requires extending the TripPlanner model to include a list of trips.
            const TripCard(
              imagePath: 'assets/images/Trips/romantic_Paris.png',
              title: 'Romantic Paris Weekend',
              location: 'Paris, France',
              days: '3 Days',
              type: 'Solo',
              tags: ['Nature', 'Romance', 'Culture'],
            ),
            const SizedBox(height: 16),
            const TripCard(
              imagePath: 'assets/images/Trips/Mediterenan.png',
              title: 'Mediterranean Adventure',
              location: 'Barcelona, Spain',
              days: '4 Days',
              type: 'Family',
              tags: ['Relaxation', 'Romance', 'Tourism'],
            ),
            const SizedBox(height: 16),
            const TripCard(
              imagePath: 'assets/images/Trips/cultural_london.png',
              title: 'Cultural London Explorer',
              location: 'London, UK',
              days: '5 Days',
              type: 'Solo',
              tags: ['British Museum', 'Theater District', '+1'],
            ),
          ],
        ),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String location;
  final String days;
  final String type;
  final List<String> tags;

  const TripCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.location,
    required this.days,
    required this.type,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Trip Image
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Trip Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 8),

                // Location, Days, Type with dividers
                Row(
                  children: [
                    // Location
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Vertical Divider
                    Container(
                      width: 1,
                      height: 12,
                      color: const Color(0xFFE5E7EB),
                    ),

                    const SizedBox(width: 8),

                    // Days
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        days,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Vertical Divider
                    Container(
                      width: 1,
                      height: 12,
                      color: const Color(0xFFE5E7EB),
                    ),

                    const SizedBox(width: 8),

                    // Type (Solo/Family)
                    const Icon(
                      Icons.person_outline,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        type,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF6B7280),
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFFF3F4F6),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF374151),
                        height: 1.5,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}