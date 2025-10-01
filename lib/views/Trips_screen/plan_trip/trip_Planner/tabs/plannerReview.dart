import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Rating Header
            const RatingHeader(),

            const SizedBox(height: 24),

            // Reviews List
            const ReviewCard(
              name: 'Maria S.',
              imagePath: null,
              rating: 5,
              tripName: 'Paris Romantic Getaway',
              review: 'Joseph planned the most amazing trip! Every detail was perfect and he knew all the hidden gems. Highly recommended.',
            ),
            const SizedBox(height: 16),
            const ReviewCard(
              name: 'James R.',
              imagePath: 'assets/images/Trips/james.png',
              rating: 5,
              tripName: 'London Cultural Tour',
              review: 'Exceptional service and local knowledge. Joseph made our first visit to Europe unforgettable.',
            ),
            const SizedBox(height: 16),
            const ReviewCard(
              name: 'Anna K.',
              imagePath: 'assets/images/Trips/Anna.png',
              rating: 4,
              tripName: 'Paris Romantic Getaway',
              review: 'Joseph planned the most amazing trip! Every detail was perfect and he knew all the hidden gems. Highly recommended.',
            ),
            const SizedBox(height: 24),

            // Load More Button
            Center(
              child: TextButton(
                onPressed: () {
                  // Handle load more
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text(
                  'Load More Reviews',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingHeader extends StatelessWidget {
  const RatingHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Rating with star
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.star, color: Colors.amber, size: 24),
            SizedBox(width: 6),
            Text(
              '4.9',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            SizedBox(width: 6),
            Text(
              '(127 Reviews)',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Subtitle
        const Text(
          'Based on completed and verified trip experiences',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final String? imagePath;
  final int rating;
  final String tripName;
  final String review;

  const ReviewCard({
    Key? key,
    required this.name,
    this.imagePath,
    required this.rating,
    required this.tripName,
    required this.review,
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
          // Profile Image or Initial
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              color: imagePath == null ? const Color(0xFFF3F4F6) : null,
              image: imagePath != null
                  ? DecorationImage(
                image: AssetImage(imagePath!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: imagePath == null
                ? Center(
              child: Text(
                name[0],
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B7280),
                ),
              ),
            )
                : null,
          ),

          const SizedBox(width: 12),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Rating Row
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Trip Name
                Text(
                  'Trip: $tripName',
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                // Review Text
                Text(
                  review,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF374151),
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