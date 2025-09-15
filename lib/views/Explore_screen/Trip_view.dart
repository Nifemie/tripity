import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Data Models
class PackingTip {
  final int number;
  final String title;
  final String description;

  PackingTip({
    required this.number,
    required this.title,
    required this.description,
  });
}

class TravelArticle {
  final String id;
  final String category;
  final String title;
  final String description;
  final String timeAgo;
  final Color categoryColor;
  final Color categoryBackgroundColor;
  final List<PackingTip> tips;
  final String conclusion;

  TravelArticle({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.categoryColor,
    required this.categoryBackgroundColor,
    required this.tips,
    required this.conclusion,
  });
}

// Sample Data Provider
final travelArticleProvider = Provider<TravelArticle>((ref) {
  return TravelArticle(
    id: '1',
    category: 'Packing',
    title: '10 Essential Packing Tips for Digital Nomads',
    description: 'Packing for a life on the move doesn\'t have to be overwhelming. Whether you\'re working from beach in Bali or a café in Berlin, here are 10 essential tips to keep your load light and your work seamless.',
    timeAgo: 'Today',
    categoryColor: const Color(0xFF3B82F6),
    categoryBackgroundColor: const Color(0xFFEFF6FF),
    tips: [
      PackingTip(
        number: 1,
        title: 'Pack Versatile Clothing',
        description: 'Choose items you can mix and match for different settings – work, casual, and outdoor.',
      ),
      PackingTip(
        number: 2,
        title: 'Use Packing Cubes',
        description: 'Stay organized and make unpacking a breeze.',
      ),
      PackingTip(
        number: 3,
        title: 'Limit Tech to Essentials',
        description: 'Bring only what you truly need (e.g., lightweight laptop, universal charger, noise-cancelling headphones).',
      ),
      PackingTip(
        number: 4,
        title: 'Bring Backup Power',
        description: 'A portable power bank can be a lifesaver on long transit days.',
      ),
      PackingTip(
        number: 5,
        title: 'Go Paperless',
        description: 'Digitize travel documents, contracts, and IDs. Use secure cloud storage.',
      ),
      PackingTip(
        number: 6,
        title: 'Microfiber Towel & Compact Toiletries',
        description: 'Save space with fast-drying towels and travel-size toiletries.',
      ),
      PackingTip(
        number: 7,
        title: 'Comfortable Shoes',
        description: 'Noise-cancelling earbuds, sleep masks, or a collectable keyboard can enhance comfort and productivity.',
      ),
      PackingTip(
        number: 8,
        title: 'Portable Wi-Fi or SIM Adapter',
        description: 'Stay connected anywhere with reliable internet solutions.',
      ),
      PackingTip(
        number: 9,
        title: 'Minimal Shoes',
        description: '2-3 pairs max: one casual, one active, one formal or work-appropriate.',
      ),
      PackingTip(
        number: 10,
        title: 'Always Carry a Small Daypack',
        description: 'Great for quick outings or coffee shop work sessions.',
      ),
    ],
    conclusion: 'Tip: Reevaluate your bag after each trip and remove what you didn\'t use.',
  );
});

// Main Detail Page Widget
class TravelTipDetailPage extends ConsumerWidget {
  const TravelTipDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final article = ref.watch(travelArticleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xFF111827),
                        size: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle share action
                      print('Share article');
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.share_outlined,
                        color: Color(0xFF111827),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Article Header
                    Text(
                      article.title,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Category and Time Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9999),
                            color: article.categoryBackgroundColor,
                          ),
                          child: Text(
                            article.category,
                            style: TextStyle(
                              color: article.categoryColor,
                              fontFamily: 'Instrument Sans',
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          article.timeAgo,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Article Description
                    Text(
                      article.description,
                      style: const TextStyle(
                        color: Color(0xFF4B5563),
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Tips List
                    ...article.tips.map((tip) => PackingTipItem(tip: tip)).toList(),

                    const SizedBox(height: 24),

                    // Conclusion
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFF9FAFB),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        article.conclusion,
                        style: const TextStyle(
                          color: Color(0xFF374151),
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Individual Tip Item Widget
class PackingTipItem extends StatelessWidget {
  final PackingTip tip;

  const PackingTipItem({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number Circle
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF3B82F6),
            ),
            child: Center(
              child: Text(
                '${tip.number}',
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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



