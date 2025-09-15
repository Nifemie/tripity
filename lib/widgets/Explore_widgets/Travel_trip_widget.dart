import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'explore_header_section.dart';
import '../../routes/router_config.dart';
import 'package:go_router/go_router.dart';

// Data Models
class TravelTip {
  final String id;
  final String category;
  final String title;
  final String description;
  final String timeAgo;
  final Color categoryColor;
  final Color categoryBackgroundColor;

  TravelTip({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.timeAgo,
    required this.categoryColor,
    required this.categoryBackgroundColor,
  });
}

// Sample Data Provider
final travelTipsProvider = Provider<List<TravelTip>>((ref) {
  return [
    TravelTip(
      id: '1',
      category: 'Packing',
      title: '10 Essential Packing Tips for Digital Nomads',
      description: 'Learn how to pack smart and travel light while having everything you need for remote work.',
      timeAgo: 'Today',
      categoryColor: const Color(0xFF3B82F6),
      categoryBackgroundColor: const Color(0xFFEFF6FF),
    ),
    TravelTip(
      id: '2',
      category: 'Safety',
      title: 'Best Travel Safety Apps and Tips',
      description: 'Stay safe while traveling with these essential apps and safety precautions.',
      timeAgo: '2 days ago',
      categoryColor: const Color(0xFFEF4444),
      categoryBackgroundColor: const Color(0xFFFEF2F2),
    ),
    TravelTip(
      id: '3',
      category: 'Budget',
      title: 'Money-Saving Travel Hacks',
      description: 'Discover insider tips to travel more for less without compromising on experience.',
      timeAgo: '1 week ago',
      categoryColor: const Color(0xFF10B981),
      categoryBackgroundColor: const Color(0xFFECFDF5),
    ),
  ];
});

// Main Widget
class TravelTipsWidget extends ConsumerWidget {
  const TravelTipsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final travelTips = ref.watch(travelTipsProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ExploreHeaderSection(
            title: 'Travel Tips & Guides',
            subtitle: 'Quick Tips for Smart Travellers',
            onViewAllTap: () {
              // Handle view more action
              print('View More tapped');
            },
          ),
        ),

        // Scrollable Cards Section
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: travelTips.length,
            itemBuilder: (context, index) {
              final tip = travelTips[index];
              return Container(
                width: 350,
                margin: EdgeInsets.only(
                  right: index == travelTips.length - 1 ? 0 : 16,
                ),
                child: TravelTipCard(tip: tip),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Individual Card Widget
class TravelTipCard extends StatelessWidget {
  final TravelTip tip;

  const TravelTipCard({Key? key, required this.tip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        color: const Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172554).withOpacity(0.08),
            offset: const Offset(0, 0),
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with category and time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: tip.categoryBackgroundColor,
                ),
                child: Text(
                  tip.category,
                  style: TextStyle(
                    color: tip.categoryColor,
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ),
              Text(
                tip.timeAgo,
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
          const SizedBox(height: 16),

          // Title
          Text(
            tip.title,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.5,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 8),

          // Description
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
          const Spacer(),

          // Bottom actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Read More Button
              GestureDetector(
                onTap: () {
                  context.push('/trip-view');
                },
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9999),
                    color: const Color(0xFFF3F4F6),
                  ),
                  child: const Center(
                    child: Text(
                      'Read More',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              // Share Button
              GestureDetector(
                onTap: () {
                  print('Share tapped for: ${tip.title}');
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.share_outlined,
                      color: Color(0xFF6B7280),
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Share',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



