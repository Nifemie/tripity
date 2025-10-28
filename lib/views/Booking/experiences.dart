import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/Bookings_widget/Experiences_tab.dart';
import 'package:tripitify/widgets/Bookings_widget/experience_card_widget.dart';
import 'package:tripitify/widgets/Bookings_widget/custom_reusable_button.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';

class ExperiencesPage extends ConsumerWidget {
  const ExperiencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(experiencesProvider);
    final favoriteExperiences = ref.watch(favoriteExperiencesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        // leadingWidth: 40,
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Experiences',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Handle search
            },
            child: Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.search,
                color: Color(0xFF111827),
                size: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle filter
            },
            child: Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/Bookings/Transport/Tuning.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF6B7280),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Tabs
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ExperiencesTabBar(),
          ),
          const SizedBox(height: 24),
          // Experience Cards
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildExperienceCards(
                      context,
                      ref,
                      experiences,
                      favoriteExperiences,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCards(
    BuildContext context,
    WidgetRef ref,
    List<ExperienceCard> experiences,
    Set<String> favoriteExperiences,
  ) {
    return Column(
      children:
          experiences.map((experience) {
            final isFavorite = favoriteExperiences.contains(experience.id);

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF172554).withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Experience Image with Overlay (full width with top rounded corners)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          children: [
                            // Experience Image - Full Width
                            Positioned.fill(
                              child: Image.asset(
                                experience.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Heart Icon Overlay
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  final favorites = ref.read(
                                    favoriteExperiencesProvider.notifier,
                                  );
                                  if (isFavorite) {
                                    favorites.state = {...favoriteExperiences}
                                      ..remove(experience.id);
                                  } else {
                                    favorites.state = {
                                      ...favoriteExperiences,
                                      experience.id,
                                    };
                                  }
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0x3D000000),
                                      ),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color:
                                            isFavorite
                                                ? const Color(0xFFEF4444)
                                                : const Color(0xFF9CA3AF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Experience Info Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ExperienceInfoSection(
                        title: experience.title,
                        description: experience.description,
                        location: experience.location,
                        duration: experience.duration,
                        category: experience.category,
                        rating: experience.rating,
                        reviewCount: experience.reviewCount,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Tags Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ExperienceTagsRow(tags: experience.tags),
                    ),
                    const SizedBox(height: 16),

                    // Price Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ExperiencePriceSection(
                        pricePerPerson: experience.pricePerPerson,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Buttons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TransportButtonRow(
                        onViewDetails: () {
                          context.push('/experience-details');
                        },
                        onBookNow: () {
                          print('Book now for ${experience.title}');
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
