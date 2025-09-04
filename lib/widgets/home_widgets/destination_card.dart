import 'package:flutter/material.dart';
import 'package:tripitify/models/home_screen/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;

  const DestinationCard({Key? key, required this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 318,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.fromLTRB(12, 16, 16, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image Container
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFD3D3D3),
            ),
            child: Stack(
              children: [
                // Image or placeholder
                destination.hasImage && destination.imagePath != null
                    ? Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(destination.imagePath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade300,
                              Colors.purple.shade300,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 48,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                destination.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                // Heart icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Destination Name
          Text(
            destination.name,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.2,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            destination.description,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // Location, Temperature, and Rating Row
          Row(
            children: [
              // Location
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Text(
                destination.country,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(width: 16),

              // Temperature
              const Icon(
                Icons.wb_sunny,
                size: 16,
                color: Colors.orange,
              ),
              const SizedBox(width: 4),
              Text(
                destination.temperature,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),

              const Spacer(),

              // Rating
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                destination.rating,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tags
          if (destination.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: destination.tags
                  .take(3)
                  .map<Widget>((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ))
                  .toList(),
            ),

          const SizedBox(height: 16),

          // Plan a Trip Button
          Container(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                // Add your navigation or action here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.04, -1.0),
                    end: Alignment(1.07, 1.0),
                    colors: [
                      Color(0xFF3B82F6), // Primary Blue 500
                      Color(0xFF2563EB), // Primary Blue 600
                      Color(0xFF1E40AF), // Primary Blue 800
                    ],
                    stops: [0.0, 0.51, 1.07],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(9999)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add your calendar icon here
                    // Icon(Icons.calendar_today, size: 16, color: Colors.white),
                    // SizedBox(width: 8),
                    Text(
                      "Plan a Trip Here",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
