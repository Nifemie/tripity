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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image Container with exact specs
          Container(
            height: 160,
            width: double.infinity,
            child: Stack(
              children: [
                // Image
                destination.hasImage && destination.imagePath != null
                    ? ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    destination.imagePath!,
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 160,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF93C5FD),
                              Color(0xFFC4B5FD),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Image not found',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Container(
                  width: double.infinity,
                  height: 10,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF93C5FD),
                        Color(0xFFC4B5FD),
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
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content Container with exact specs
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Rating Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        destination.name,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                          height: 1.5, // 24px / 16px = 1.5
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: Color(0xFFFBBF24),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          destination.rating,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Description with exact specs
                Text(
                  destination.description,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF4B5563),
                    height: 1.5, // 18px / 12px = 1.5
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),

                const SizedBox(height: 16),

                // Tags with exact specs
                if (destination.tags.isNotEmpty)
                  Row(
                    children: [
                      // Regular tags
                      ...destination.tags.take(3).map<Widget>((tag) =>
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3F4F6),
                              borderRadius: BorderRadius.all(Radius.circular(9999)),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF4B5563),
                              ),
                            ),
                          ),
                      ),
                      // +1 tag if there are more than 3 tags
                      if (destination.tags.length > 3)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(9999)),
                            border: Border.all(
                              color: const Color(0xFFF3F4F6),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '+${destination.tags.length - 3}',
                            style: const TextStyle(
                              fontFamily: 'Instrument Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF4B5563),
                            ),
                          ),
                        ),
                    ],
                  ),

                const SizedBox(height: 16),

                // Button with exact specs
                Container(
                  width: 318,
                  height: 44,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.04, -1.0),
                      end: Alignment(1.07, 1.0),
                      colors: [
                        Color(0xFF3B82F6), // Primary Blue 500
                        Color(0xFF2563EB), // Primary Blue 600
                        Color(0xFF1E40AF), // Primary Blue 800
                      ],
                      stops: [0.0, 0.5145, 1.0712],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your navigation or action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9999)),
                      ),
                    ),
                    child: const Text(
                      "Discover Destination",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.25, // 17.5px / 14px = 1.25
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