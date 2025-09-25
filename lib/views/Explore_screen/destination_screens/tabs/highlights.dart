import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Models
class Highlight {
  final String title;
  final String description;
  final String imageUrl;

  const Highlight({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
// Experience Call-to-Action Widget
class ExperienceCallToActionWidget extends StatelessWidget {
  const ExperienceCallToActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: AppColors.primaryBlue50,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Title Row
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/Home/Calendar_icon.svg',
                width: 24,
                height: 24,
                color: Colors.blue,
              ),
              const SizedBox(width: 8),
              const Text(
                'Ready to Experience These?',
                style: AppTextStyles.heading6Blue,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Description Text
          const Text(
            'Book activities, hotels, events, and flights for Paris in our marketplace.',
            style: AppTextStyles.bodySmall,
          ),
          const SizedBox(height: 16),
          // Browse Travel Options Button
          Container(
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: AppColors.neutralWhite,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () {
                  // Handle button tap
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Center(
                    child: Text(
                      'Browse Travel Options',
                      style: AppTextStyles.buttonSmall,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




// Providers
final highlightsProvider = Provider<List<Highlight>>((ref) {
  return [
    const Highlight(
      title: "Eiffel Tower",
      description: "Iconic iron lattice tower and symbol of Paris",
      imageUrl: "assets/images/explore/effel_tower.jpg", // Replace with actual image path
    ),
    const Highlight(
      title: "Louvre Museum",
      description: "World's largest art museum, home to the Mona Lisa",
      imageUrl: "assets/images/explore/Louvre.png", // Replace with actual image path
    ),
    const Highlight(
      title: "Notre-Dame Cathedral",
      description: "Gothic masterpiece on Île de la Cité",
      imageUrl: "assets/images/explore/Notre.png", // Replace with actual image path
    ),
  ];
});

// Design Constants
class AppColors {
  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF4B5563);
  static const textTertiary = Color(0xFF6B7280);
  static const surfaceCard = Color(0xFFFFFFFF);
  static const primaryBlue50 = Color(0xFFEFF6FF);
  static const primaryBlue500 = Color(0xFF3B82F6);
  static const primaryBlue900 = Color(0xFF1E3A8A);
  static const neutralWhite = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static const heading6 = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5, // 24px / 16px = 1.5
    letterSpacing: 0,
    color: AppColors.textPrimary,
  );

  static const heading6Blue = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5, // 24px / 16px = 1.5
    letterSpacing: 0,
    color: AppColors.primaryBlue900,
  );

  static const bodySmall = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5, // 21px / 14px = 1.5
    color: AppColors.textSecondary,
  );

  static const buttonSmall = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.25, // 17.5px / 14px = 1.25
    color: AppColors.primaryBlue500,
  );

  static const caption = TextStyle(
    fontFamily: 'Instrument Sans',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.5, // 18px / 12px = 1.5
    color: AppColors.textTertiary,
  );
}

// Main Widget
class TopHighlightsWidget extends ConsumerWidget {
  const TopHighlightsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final highlights = ref.watch(highlightsProvider);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: highlights.length + 2, // +1 for title, +1 for CTA
      itemBuilder: (context, index) {
        if (index == 0) {
          // Title
          return const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
              'Top Highlights',
              style: AppTextStyles.heading6,
            ),
          );
        } else if (index <= highlights.length) {
          // Highlight Cards
          final highlight = highlights[index - 1];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: HighlightCard(highlight: highlight),
          );
        } else {
          // Call to Action Widget
          return const ExperienceCallToActionWidget();
        }
      },
    );
  }
}

// Individual Highlight Card
class HighlightCard extends StatelessWidget {
  final Highlight highlight;

  const HighlightCard({
    super.key,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image Container
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    highlight.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Optional: A fallback widget in case of error
                      return Container(
                        color: Colors.grey,
                        child: const Center(
                          child: Icon(Icons.image_not_supported, color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.3),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text Container
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  highlight.title,
                  style: AppTextStyles.heading6,
                ),
                const SizedBox(height: 8),
                Text(
                  highlight.description,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

