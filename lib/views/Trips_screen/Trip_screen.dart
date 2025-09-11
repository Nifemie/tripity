// lib/views/trips/upcoming_trip.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../views/Trips_screen/Ongoing_trip.dart';
import '../../views/Trips_screen/Upcoming_trip.dart';
import '../../views/Trips_screen/Completed_trip.dart';
import '../../views/Trips_screen/Cancelled_trip.dart';
import 'package:go_router/go_router.dart';


// State provider for selected tab
final selectedTabProvider = StateProvider<int>((ref) => 0);

class TripPage extends ConsumerWidget {
  const TripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar Section
            _buildAppBar(context),

            // Tab Navigation
            _buildTabNavigation(context, ref, selectedTab),

            // Content Area
            Expanded(
              child: _buildContent(selectedTab),
            ),
          ],
        ),
      ),

    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // My Trips
          const Text(
            'My Trips',
            style: TextStyle(
              color: Color(0xFF111827),
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.375,
            ),
          ),

          Row(
            children: [
              // Trip Requests Button
              Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFF3F4F6),
                ),
                child: const Center(
                  child: Text(
                    'Trip Requests',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // New Trip Button
              GestureDetector(
                onTap: () {
                  context.push('/plan-new-trip');
                },
                child: Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment(-0.04, -1),
                      end: Alignment(1.07, 1),
                      colors: [
                        Color(0xFF3B82F6),
                        Color(0xFF2563EB),
                        Color(0xFF1E40AF),
                      ],
                      stops: [0.0, 0.51, 1.0],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/images/Trips/Add.svg',
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'New Trip',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabNavigation(BuildContext context, WidgetRef ref, int selectedTab) {
    final tabs = ['Upcoming', 'Ongoing', 'Completed', 'Cancelled'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isSelected = index == selectedTab;

          return Expanded(
            child: GestureDetector(
              onTap: () => ref.read(selectedTabProvider.notifier).state = index,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: isSelected
                      ? const Border(
                    bottom: BorderSide(
                      color: Color(0xFF3B82F6),
                      width: 2.5,
                    ),
                  )
                      : null,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF111827)
                        : const Color(0xFF6B7280),
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w500
                        : FontWeight.w400,
                    height: isSelected ? 1.25 : 1.5,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildContent(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const UpcomingContent();
      case 1:
        return const OngoingContent();
      case 2:
        return const CompletedContent();
      case 3:
        return const CancelledContent();
      default:
        return const UpcomingContent();
    }
  }
}
