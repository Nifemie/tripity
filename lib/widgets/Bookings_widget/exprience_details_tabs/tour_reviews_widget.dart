import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

// ==================== REVIEW MODEL ====================

class TourReview {
  final String id;
  final String reviewerName;
  final String date;
  final int rating;
  final String reviewText;
  final int helpfulCount;

  TourReview({
    required this.id,
    required this.reviewerName,
    required this.date,
    required this.rating,
    required this.reviewText,
    required this.helpfulCount,
  });
}

// ==================== REVIEWS PROVIDER ====================

final tourReviewsProvider = Provider<List<TourReview>>((ref) {
  return [
    TourReview(
      id: '1',
      reviewerName: 'Sarah M.',
      date: '12/09/2025',
      rating: 5,
      reviewText:
          'Amazing experience. The guide was knowledgeable and the food was incredible. Highly recommend',
      helpfulCount: 12,
    ),
    TourReview(
      id: '2',
      reviewerName: 'Mike J.',
      date: '06/09/2025',
      rating: 4,
      reviewText:
          'Great tour, learned a lot about local culture. Only wish it was a bit longer.',
      helpfulCount: 8,
    ),
    TourReview(
      id: '3',
      reviewerName: 'Emma L.',
      date: '06/09/2025',
      rating: 5,
      reviewText:
          'Perfect activities for families. Kids loved it and so did we.',
      helpfulCount: 8,
    ),
  ];
});

// ==================== RATING SUMMARY ====================

class RatingSummary {
  final double averageRating;
  final int totalReviews;
  final Map<int, double> ratingPercentages;

  RatingSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingPercentages,
  });
}

final ratingSummaryProvider = Provider<RatingSummary>((ref) {
  return RatingSummary(
    averageRating: 4.7,
    totalReviews: 892,
    ratingPercentages: {5: 0.42, 4: 0.36, 3: 0.49, 2: 0.42, 1: 0.73},
  );
});

// ==================== TOUR REVIEWS WIDGET ====================

class TourReviewsWidget extends ConsumerWidget {
  const TourReviewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(tourReviewsProvider);
    final ratingSummary = ref.watch(ratingSummaryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Rating Summary Section
        _buildRatingSummary(ratingSummary),
        const SizedBox(height: 24),

        // Reviews List
        ...reviews.map(
          (review) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildReviewCard(review),
          ),
        ),
      ],
    );
  }

  // Rating Summary Card
  Widget _buildRatingSummary(RatingSummary summary) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172554).withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Side - Average Rating
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/Bookings/Star.svg',
                width: 24,
                height: 24,
              ),
              const SizedBox(height: 4),
              Text(
                summary.averageRating.toString(),
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 48,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${summary.totalReviews} Reviews',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Right Side - Rating Bars
          Expanded(
            child: Column(
              children: [
                _buildRatingBar(5, summary.ratingPercentages[5] ?? 0),
                const SizedBox(height: 8),
                _buildRatingBar(4, summary.ratingPercentages[4] ?? 0),
                const SizedBox(height: 8),
                _buildRatingBar(3, summary.ratingPercentages[3] ?? 0),
                const SizedBox(height: 8),
                _buildRatingBar(2, summary.ratingPercentages[2] ?? 0),
                const SizedBox(height: 8),
                _buildRatingBar(1, summary.ratingPercentages[1] ?? 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Individual Rating Bar
  Widget _buildRatingBar(int stars, double percentage) {
    return Row(
      children: [
        // Star Number
        Text(
          stars.toString(),
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
        const SizedBox(width: 4),
        // Star Icon
        SvgPicture.asset(
          'assets/images/Bookings/Star.svg',
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        // Progress Bar
        Expanded(
          child: Stack(
            children: [
              // Background Bar
              Container(
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: const Color(0xFFF3F4F6),
                ),
              ),
              // Progress Bar (using SVG)
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFFBBC04),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Percentage
        SizedBox(
          width: 40,
          child: Text(
            '${(percentage * 100).toInt()}%',
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // Review Card
  Widget _buildReviewCard(TourReview review) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172554).withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - Name and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.reviewerName,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
              Text(
                review.date,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Star Rating
          Row(
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 4),
                child: SvgPicture.asset(
                  'assets/images/Bookings/Star.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    index < review.rating
                        ? const Color(0xFFFBBC04)
                        : const Color(0xFFE5E7EB),
                    BlendMode.srcIn,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),

          // Review Text
          Text(
            review.reviewText,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Helpful Button
          Row(
            children: [
              const Icon(
                Icons.favorite_border,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 8),
              Text(
                'Helpful (${review.helpfulCount})',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
