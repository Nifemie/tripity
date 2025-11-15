import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/more_widgets/reviews/review_card.dart';
import '../../widgets/more_widgets/reviews/write_review_sheet.dart';
import '../../widgets/more_widgets/reviews/edit_review_sheet.dart';

// Review Tab enum
enum ReviewTab { all, trips, bookings, pending }

// Review tab provider
final reviewTabProvider = StateProvider<ReviewTab>((ref) => ReviewTab.all);

class RatingReviewsScreen extends ConsumerWidget {
  const RatingReviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(reviewTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 18,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Reviews & Ratings',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildTab(
                        context, ref, 'All', ReviewTab.all, selectedTab, 3),
                    const SizedBox(width: 12),
                    _buildTab(
                        context, ref, 'Trips', ReviewTab.trips, selectedTab, 1),
                    const SizedBox(width: 12),
                    _buildTab(context, ref, 'Bookings', ReviewTab.bookings,
                        selectedTab, 2),
                    const SizedBox(width: 12),
                    _buildTab(context, ref, 'Pending', ReviewTab.pending,
                        selectedTab, 2),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildContent(context, selectedTab),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    WidgetRef ref,
    String label,
    ReviewTab tab,
    ReviewTab selectedTab,
    int count,
  ) {
    final isSelected = selectedTab == tab;

    return GestureDetector(
      onTap: () {
        ref.read(reviewTabProvider.notifier).state = tab;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDBEAFE) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ReviewTab selectedTab) {
    switch (selectedTab) {
      case ReviewTab.all:
        return _buildAllReviews(context);
      case ReviewTab.trips:
        return _buildTripsReviews(context);
      case ReviewTab.bookings:
        return _buildBookingsReviews(context);
      case ReviewTab.pending:
        return _buildPendingReviews(context);
    }
  }

  Widget _buildAllReviews(BuildContext context) {
    return Column(
      children: [
        ReviewCard(
          title: 'Grand Hyatt Tokyo',
          subtitle: 'Tokyo, Japan',
          rating: 5.0,
          reviewText:
              'Absolutely stunning hotel! The service was impeccable and the views from the room were breath-taking. The breakfast buffet has an amazing variety. Highly recommend!',
          imageUrl: 'assets/images/explore/effel_tower.jpg',
          timeAgo: '2 hours ago',
          helpfulCount: 12,
          onEdit: () => _showEditReviewSheet(context, isExistingReview: true),
        ),
        ReviewCard(
          title: 'Naomi Anigbogu',
          hasImage: true,
          userImagePath: 'assets/images/Profile.jpg',
          subtitle: 'All-Day Trip',
          rating: 5.0,
          reviewText:
              'Naomi planned the most amazing trip! Every detail was perfect and we knew all the hidden gems. Highly recommended.',
          timeAgo: 'Jun 8, 2025',
          helpfulCount: 12,
          onEdit: () => _showEditReviewSheet(context, isExistingReview: true),
        ),
        ReviewCard(
          title: 'Grand Hyatt Tokyo',
          subtitle: 'Tokyo, Japan',
          rating: 5.0,
          reviewText:
              'Absolutely stunning hotel! The service was impeccable and the views from the room were breath-taking. The breakfast buffet has an amazing variety. Highly recommend!',
          imageUrl: 'assets/images/explore/effel_tower.jpg',
          timeAgo: '2 hours ago',
          helpfulCount: 12,
          onEdit: () => _showEditReviewSheet(context, isExistingReview: true),
        ),
      ],
    );
  }

  Widget _buildTripsReviews(BuildContext context) {
    return Column(
      children: [
        ReviewCard(
          title: 'Naomi Anigbogu',
          hasImage: true,
          userImagePath: 'assets/images/Profile.jpg',
          subtitle: 'All-Day Trip',
          rating: 5.0,
          reviewText:
              'Naomi planned the most amazing trip! Every detail was perfect and we knew all the hidden gems. Highly recommended.',
          timeAgo: 'Jun 8, 2025',
          helpfulCount: 12,
          onEdit: () => _showEditReviewSheet(context, isExistingReview: true),
        ),
      ],
    );
  }

  Widget _buildBookingsReviews(BuildContext context) {
    return Column(
      children: [
        ReviewCard(
          title: 'Grand Hyatt Tokyo',
          subtitle: 'Tokyo, Japan',
          rating: 5.0,
          reviewText:
              'Absolutely stunning hotel! The service was impeccable and the views from the room were breath-taking. The breakfast buffet has an amazing variety. Highly recommend!',
          imageUrl: 'assets/images/explore/effel_tower.jpg',
          timeAgo: '2 hours ago',
          helpfulCount: 12,
          onEdit: () => _showEditReviewSheet(context, isExistingReview: true),
        ),
      ],
    );
  }

  Widget _buildPendingReviews(BuildContext context) {
    return Column(
      children: [
        PendingReviewCard(
          title: 'Mariot Hotel Bangkok',
          subtitle: 'Bangkok, Thailand',
          category: 'Hotel',
          question: 'How was your experience at Marriot Hotel Bangkok?',
          onWriteReview: () => _showWriteReviewSheet(context),
        ),
        const SizedBox(height: 16),
        PendingReviewCard(
          title: 'Temple Tour',
          subtitle: 'Bangkok, Thailand',
          category: 'Experience',
          question: 'How was your experience at Temple Tour?',
          onWriteReview: () => _showWriteReviewSheet(context),
        ),
      ],
    );
  }

  void _showWriteReviewSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const WriteReviewSheet(
        title: 'Mariot Hotel Bangkok',
        subtitle: 'Bangkok, Thailand',
      ),
    );
  }

  void _showEditReviewSheet(BuildContext context,
      {required bool isExistingReview}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const EditReviewSheet(
        title: 'Grand Hyatt Tokyo',
        subtitle: 'Tokyo, Japan',
        initialRating: 5,
        initialReview:
            'Absolutely stunning hotel! The service was impeccable and the views from the room were breath-taking. The breakfast buffet has an amazing variety. Highly recommend!',
      ),
    );
  }
}
