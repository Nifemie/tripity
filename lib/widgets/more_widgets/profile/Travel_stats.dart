import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Travel Stat Data Model
class TravelStat {
  final String iconPath;
  final int count;
  final String label;

  const TravelStat({
    required this.iconPath,
    required this.count,
    required this.label,
  });
}

// Trips Completed provider
final tripsCompletedProvider = StateProvider<int>((ref) => 12);

// Countries Visited provider
final countriesVisitedProvider = StateProvider<int>((ref) => 8);

// Reviews Written provider
final reviewsWrittenProvider = StateProvider<int>((ref) => 24);

// Photos Shared provider
final photosSharedProvider = StateProvider<int>((ref) => 156);

// Travel Stats provider
final travelStatsProvider = Provider<List<TravelStat>>((ref) {
  final tripsCompleted = ref.watch(tripsCompletedProvider);
  final countriesVisited = ref.watch(countriesVisitedProvider);
  final reviewsWritten = ref.watch(reviewsWrittenProvider);
  final photosShared = ref.watch(photosSharedProvider);

  return [
    TravelStat(
      iconPath: 'assets/nice/icons.svg',
      count: tripsCompleted,
      label: 'Trips Completed',
    ),
    TravelStat(
      iconPath: 'assets/nice/icons.svg',
      count: countriesVisited,
      label: 'Countries Visited',
    ),
    TravelStat(
      iconPath: 'assets/nice/icons.svg',
      count: reviewsWritten,
      label: 'Reviews Written',
    ),
    TravelStat(
      iconPath: 'assets/nice/icons.svg',
      count: photosShared,
      label: 'Photos Shared',
    ),
  ];
});

// Travel Stats Widget
class TravelStatsWidget extends ConsumerWidget {
  const TravelStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final travelStats = ref.watch(travelStatsProvider);

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: travelStats.map((stat) {
        return _TravelStatCard(stat: stat);
      }).toList(),
    );
  }
}

// Travel Stat Card
class _TravelStatCard extends StatelessWidget {
  final TravelStat stat;

  const _TravelStatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    // Calculate card width to fit 2 per row with proper spacing
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 44) / 2; // 16 padding left + 16 right + 12 spacing

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF3F4F6),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14172554),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          SvgPicture.asset(
            stat.iconPath,
            width: 32,
            height: 32,
            colorFilter: const ColorFilter.mode(
              Color(0xFF3B82F6),
              BlendMode.srcIn,
            ),
          ),

          const SizedBox(height: 8),

          // Count
          Text(
            '${stat.count}',
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 4),

          // Label
          Text(
            stat.label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// Example Usage
class TravelStatsExample extends ConsumerWidget {
  const TravelStatsExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text('Travel Stats'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TravelStatsWidget(),
            const SizedBox(height: 16),
            // Example: Update stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(tripsCompletedProvider.notifier).state++;
                  },
                  child: const Text('+ Trip'),
                ),
                ElevatedButton(
                  onPressed: () {
                    ref.read(reviewsWrittenProvider.notifier).state++;
                  },
                  child: const Text('+ Review'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}