import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

// ==================== MODELS ====================

class Category {
  final String id;
  final String label;
  final String iconPath;
  final VoidCallback? onTap;

  const Category({
    required this.id,
    required this.label,
    required this.iconPath,
    this.onTap,
  });
}

// ==================== RIVERPOD PROVIDERS ====================

// Provider for selected category
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// Provider for categories list
final categoriesProvider = Provider<List<Category>>((ref) {
  return [
    Category(
      id: 'transport',
      label: 'Transport',
      iconPath: 'assets/images/Bookings/Transport_Plane.svg',
    ),
    Category(
      id: 'stays',
      label: 'Stays',
      iconPath: 'assets/images/Home/Home.svg',
    ),
    Category(
      id: 'experiences',
      label: 'Experiences',
      iconPath: 'assets/images/explore/Microphone.svg',
    ),
    Category(
      id: 'events',
      label: 'Events',
      iconPath: 'assets/images/Bookings/Ticket.svg',
    ),
  ];
});

// ==================== SECTION HEADER WIDGET ====================

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onActionTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with optional action
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
                height: 1.4,
              ),
            ),
            if (actionText != null)
              GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionText!,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF3B82F6), // Primary blue
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ),

        // Subtitle if provided
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280), // Tertiary text
              height: 1.5,
            ),
          ),
        ],
      ],
    );
  }
}

// ==================== CATEGORY CARD WIDGET ====================

class CategoryCard extends ConsumerWidget {
  final Category category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final isSelected = selectedCategory == category.id;

    return GestureDetector(
      onTap: () {
        // Update selected category
        ref.read(selectedCategoryProvider.notifier).state = category.id;

        // Call custom callback if provided
        category.onTap?.call();

        // Navigate to TransportPage if transport category is selected
        if (category.id == 'transport') {
          context.push('/transport');
        }

        // Navigate to StaysPage if stays category is selected
        if (category.id == 'stays') {
          context.push('/stays');
        }

        // Navigate to ExperiencesPage if experiences category is selected
        if (category.id == 'experiences') {
          context.push('/experiences');
        }

        // Navigate to EventsPage if events category is selected
        if (category.id == 'events') {
          context.push('/events');
        }

        // Log selection
        print('Selected category: ${category.label}');
      },
      child: Container(
        width: 187,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6), // #F3F4F6
          borderRadius: BorderRadius.circular(24), // 24px radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: Icon (left) and Arrow (right)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category Icon
                SvgPicture.asset(
                  category.iconPath,
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF111827), // Dark icon color
                    BlendMode.srcIn,
                  ),
                ),

                // Forward Arrow Icon
                SvgPicture.asset(
                  'assets/images/Home/ArrowRightUp.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF9CA3AF), // Gray arrow
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20), // 20px gap
            // Label Text
            Text(
              category.label,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500, // Medium weight (500)
                color: Color(0xFF111827), // #111827 Primary text
                height: 1.25, // 125% line height (17.5px / 14px)
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CATEGORY GRID WIDGET ====================

class CategoryGrid extends ConsumerWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);

    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive spacing
    final horizontalSpacing = _getHorizontalSpacing(screenWidth);
    final cardWidth = _getCardWidth(screenWidth);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Determine number of columns based on available width
          final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 187 / 113, // width / height ratio
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: categories[index]);
            },
          );
        },
      ),
    );
  }

  // Responsive helper methods
  double _getHorizontalSpacing(double screenWidth) {
    if (screenWidth > 1200) return 48.0; // Desktop
    if (screenWidth > 600) return 32.0; // Tablet
    return 16.0; // Mobile
  }

  double _getCardWidth(double screenWidth) {
    if (screenWidth > 1200) return 220.0; // Desktop
    if (screenWidth > 600) return 200.0; // Tablet
    return 187.0; // Mobile (original design)
  }

  int _getCrossAxisCount(double availableWidth) {
    if (availableWidth > 800) return 4; // 4 columns on large screens
    if (availableWidth > 500) return 3; // 3 columns on medium screens
    return 2; // 2 columns on mobile (original design)
  }
}

// ==================== COMPLETE CATEGORY SECTION ====================

class CategorySection extends ConsumerWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SectionHeader(
            title: 'What are you looking for?',
            subtitle: 'Choose a category to start exploring tailored options.',
          ),
        ),

        const SizedBox(height: 16),

        // Category Grid
        const CategoryGrid(),
      ],
    );
  }
}

// ==================== USAGE EXAMPLE ====================

class CategorySectionExample extends ConsumerWidget {
  const CategorySectionExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Category Section
              const CategorySection(),

              const SizedBox(height: 24),

              // Show selected category feedback
              if (selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'You selected: $selectedCategory',
                      style: const TextStyle(
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
      ),
    );
  }
}

// ==================== RESPONSIVE CATEGORY CARD (ALTERNATIVE) ====================
// This version automatically adjusts width based on container

class ResponsiveCategoryCard extends ConsumerWidget {
  final Category category;

  const ResponsiveCategoryCard({Key? key, required this.category})
    : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use available width instead of fixed 187px
        return GestureDetector(
          onTap: () {
            ref.read(selectedCategoryProvider.notifier).state = category.id;
            category.onTap?.call();
            print('Selected category: ${category.label}');
          },
          child: Container(
            width: constraints.maxWidth,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      category.iconPath,
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF111827),
                        BlendMode.srcIn,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 20,
                      color: Color(0xFF9CA3AF),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  category.label,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
