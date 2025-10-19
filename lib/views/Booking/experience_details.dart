import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui' as ui;
import 'package:tripitify/widgets/Bookings_widget/booking_footer.dart';
import 'package:tripitify/widgets/Bookings_widget/exprience_details_tabs/tour_reviews_widget.dart';
import 'package:tripitify/widgets/Bookings_widget/exprience_details_tabs/FAQs.dart';

// ==================== TAB PROVIDER ====================

final selectedDetailsTabProvider = StateProvider<String>((ref) => 'Details');

// ==================== FAVORITE PROVIDER ====================

final isFavoriteExperienceDetailProvider = StateProvider<bool>((ref) => false);

// ==================== EXPERIENCE DETAILS PAGE ====================

class ExperienceDetailsPage extends ConsumerWidget {
  const ExperienceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedDetailsTabProvider);
    final isFavorite = ref.watch(isFavoriteExperienceDetailProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          Column(
            children: [
              // Hero Image with Overlay (Static)
              _buildHeroImage(context, ref, isFavorite),

              // Content Section (Static Header + Scrollable Content)
              Expanded(
                child: Column(
                  children: [
                    // Static Content (Title, Rating, Tabs)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Rating
                          _buildTitleSection(),
                          const SizedBox(height: 16),

                          // Tab Bar
                          _buildTabBar(ref, selectedTab),
                        ],
                      ),
                    ),

                    // Scrollable Tab Content
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            16.0,
                            24.0,
                            16.0,
                            100.0,
                          ),
                          child: Column(
                            children: [
                              // Tab Content
                              if (selectedTab == 'Details') _buildDetailsTab(),
                              if (selectedTab == 'Reviews') _buildReviewsTab(),
                              if (selectedTab == 'FAQs') _buildFAQsTab(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Booking Footer
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BookingFooter(
              pricePerPerson: 45.0,
              priceLabel: 'person',
              onBookNow: () {
                final quantity = ref.read(bookingQuantityProvider);
                print('Booking for $quantity people');
              },
            ),
          ),
        ],
      ),
    );
  }

  // Hero Image with Overlay Controls
  Widget _buildHeroImage(BuildContext context, WidgetRef ref, bool isFavorite) {
    return Stack(
      children: [
        // Image
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.asset(
            'assets/images/Bookings/experience/paris_walking.png',
            fit: BoxFit.cover,
          ),
        ),

        // Gradient Overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF000000).withOpacity(0.3),
                  const Color(0xFF000000).withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),

        // Top Controls
        Positioned(
          top: 50,
          left: 16,
          right: 16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFF000000).withOpacity(0.24),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),

              // Favorite Button
              GestureDetector(
                onTap: () {
                  ref.read(isFavoriteExperienceDetailProvider.notifier).state =
                      !isFavorite;
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(8.8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF000000).withOpacity(0.24),
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color:
                            isFavorite ? const Color(0xFFEF4444) : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Title Section
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Paris Walking Tour: Montmartre & Artists',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                      height: 1.33,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'By Paris Walking Tours',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Rating
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/Bookings/Star.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 4),
                const Text(
                  '4.7',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Tab Bar
  Widget _buildTabBar(WidgetRef ref, String selectedTab) {
    final tabs = ['Details', 'Reviews', 'FAQs'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          tabs.map((tab) {
            final isSelected = selectedTab == tab;
            return GestureDetector(
              onTap: () {
                ref.read(selectedDetailsTabProvider.notifier).state = tab;
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                          isSelected
                              ? const Color(0xFF3B82F6)
                              : Colors.transparent,
                      width: 2.5,
                    ),
                  ),
                ),
                child: Text(
                  tab,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        isSelected
                            ? const Color(0xFF000000)
                            : const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  // Details Tab Content
  Widget _buildDetailsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // About This Experience
        _buildSectionCard(
          title: 'About This Experience',
          content: const Text(
            'Discover the artistic heart of Paris on this immersive walking tour through Montmartre. Explore the charming streets where famous artists like Picasso and Van Gogh once lived and worked. Visit iconic landmarks including the Sacré-Cœur Basilica and learn about the rich cultural history of this bohemian neighborhood.',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Highlights
        _buildSectionCard(
          title: 'Highlights',
          content: Column(
            children: [
              _buildCheckItem('Visit Sacré-Cœur Basilica'),
              _buildCheckItem('Explore artistic studios and galleries'),
              _buildCheckItem('Walk through Place du Tertre'),
              _buildCheckItem('See the Moulin Rouge from outside'),
              _buildCheckItem('Learn about famous artists of Montmartre'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // What's Included
        _buildSectionCard(
          title: "What's Included",
          content: Column(
            children: [
              _buildArrowItem('Expert local guide'),
              _buildArrowItem('Small group tour (max 15 people)'),
              _buildArrowItem('Headsets for clear communication'),
              _buildArrowItem('Walking tour map'),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Divider Line
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xFFF3F4F6),
        ),
        const SizedBox(height: 24),

        // Quick Details
        _buildQuickDetails(),
        const SizedBox(height: 24),

        // Divider Line
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xFFF3F4F6),
        ),
        const SizedBox(height: 24),

        // Location & Meeting Point
        _buildLocationSection(),
        const SizedBox(height: 24),

        // Divider Line
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xFFF3F4F6),
        ),
        const SizedBox(height: 24),

        // Accessibility
        _buildAccessibilitySection(),
        const SizedBox(height: 24),

        // Divider Line
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xFFF3F4F6),
        ),
        const SizedBox(height: 24),

        // Cancellation Policy
        _buildCancellationPolicy(),
        const SizedBox(height: 38),
      ],
    );
  }

  // Section Card
  Widget _buildSectionCard({required String title, required Widget content}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.33,
            ),
          ),
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }

  // Check Item
  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/Bookings/Check_Circle.svg', // Placeholder - replace with actual path
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0xFF10B981),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Arrow Item
  Widget _buildArrowItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/Bookings/Double_Alt_Arrow Right.svg', // Placeholder - replace with actual path
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0xFF3B82F6),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Details
  Widget _buildQuickDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Details',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildDetailItem(
          'assets/images/Bookings/Clock.svg',
          'Duration',
          '2.5 hours',
        ),
        _buildDetailItem(
          'assets/images/account_setup/Users.svg',
          'Group Size',
          'Maximum 15 people',
        ),
        _buildDetailItem(
          'assets/images/Bookings/Info_Circle.svg',
          'Age Requirements',
          'All ages are welcome',
        ),
        _buildDetailItem(
          'assets/images/Trips/Global.svg',
          'Languages',
          'English, French',
        ),
      ],
    );
  }

  Widget _buildDetailItem(String iconPath, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              Color(0xFF6B7280),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                Text(
                  value,
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
          ),
        ],
      ),
    );
  }

  // Location Section
  Widget _buildLocationSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Location & Meeting Point',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/Bookings/location.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                Color(0xFF6B7280),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Paris, France',
              style: TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
                height: 1.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 36),
          child: Text(
            'Montmatre District, Paris',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFEFF6FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Meeting Instructions',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Meet your guide at the Abbesses Metro Station exit. Look for the guide holding a blue Paris Walking Tours sign.',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Accessibility Section
  Widget _buildAccessibilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accessibility',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        _buildAccessibilityItem(
          'assets/images/Bookings/Clock.svg',
          'Wheelchair accessible venues when possible',
        ),
        const SizedBox(height: 12),
        _buildAccessibilityItem(
          'assets/images/account_setup/Users.svg',
          'Suitable for most mobility levels',
        ),
        const SizedBox(height: 16),
        const Text(
          'Please contact us before booking if you have specific accessibility requirements.',
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

  // Accessibility Item
  Widget _buildAccessibilityItem(String iconPath, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            Color(0xFF6B7280),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  // Cancellation Policy
  Widget _buildCancellationPolicy() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cancellation Policy',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        // Free cancellation line
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/images/Bookings/Refresh.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                Color(0xFF10B981),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Free cancellation up to 24 hours before',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Flexible Booking Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFEFF6FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Flexible Booking:',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'We understand plans change. Contact us for special circumstances and we\'ll work with you.',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Reviews Tab
  Widget _buildReviewsTab() {
    return const TourReviewsWidget();
  }

  // FAQs Tab
  Widget _buildFAQsTab() {
    return const FAQsWidget();
  }
}
