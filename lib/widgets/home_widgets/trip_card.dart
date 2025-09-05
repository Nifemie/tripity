import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/upcoming_trip.dart';

class TripCard extends StatelessWidget {
  final UpcomingTrip trip;

  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with image and title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip image
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                    image: trip.imagePath != null
                        ? DecorationImage(
                            image: AssetImage(trip.imagePath!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: trip.imagePath == null
                      ? Icon(Icons.image, color: Colors.grey[600])
                      : null,
                ),

                const SizedBox(width: 12),

                // Title and status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          color: trip.status == 'Confirmed'
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEF3C7),
                        ),
                        child: Text(
                          trip.status,
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: trip.status == 'Confirmed'
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFF59E0B),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Trip details
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.location,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.dates,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.type,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  trip.price,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Planner and View Trip button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planner",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      trip.planner,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    // Handle view trip
                    debugPrint("View trip: ${trip.title}");
                  },
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: const Color(0xFFF3F4F6),
                    ),
                    child: const Center(
                      child: Text(
                        "View Trip",
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
