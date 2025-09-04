import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/trip.dart';

class TripCountdownCard extends StatelessWidget {
  final Trip trip;

  const TripCountdownCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Days counter
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "STARTS IN",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${trip.daysUntilStart}",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "DAYS",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your ${trip.destination} trip starts in ${trip.daysUntilStart} days",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text("Jul 27 - Jul 31, 2025",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${trip.destination}, ${trip.country}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "It's time to start packing up your bag",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                    height: 1.5,
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
