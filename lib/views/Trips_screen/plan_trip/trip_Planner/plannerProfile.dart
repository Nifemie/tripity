import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/tabs/PlannerOverview.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/tabs/plannerTripPlanned.dart'; // Import TripsPlannedScreen
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/tabs/plannerReview.dart';
import 'package:tripitify/widgets/Trip_planner/profilePlanner_button.dart';

// State provider for selected tab
final selectedProfileTabProvider = StateProvider<String>((ref) => 'Overview');

class TripPlannerProfileScreen extends ConsumerWidget {
  final TripPlanner planner;

  const TripPlannerProfileScreen({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0, // Ensure no shadow when scrolled
        surfaceTintColor: Colors.transparent, // Prevent tinting when scrolled
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Trip Planner Profile',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.375,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Header Section
                    ProfileHeaderSection(planner: planner),

                    const SizedBox(height: 24),

                    // Stats Section
                    StatsSection(planner: planner),

                    const SizedBox(height: 24),

                    // Tab Navigation
                    const ProfileTabNavigation(),

                    const SizedBox(height: 24),

                    // Tab Content
                    Consumer(
                      builder: (context, ref, child) {
                        final selectedTab = ref.watch(selectedProfileTabProvider);
                        if (selectedTab == 'Overview') {
                          return PlannerOverviewScreen(planner: planner);
                        } else if (selectedTab == 'Trips Planned') {
                          return TripsPlannedScreen(planner: planner);
                        } else if (selectedTab == 'Reviews') {
                          return const ReviewsScreen();
                        }
                        // Add other tab views here
                        return Container(); // Placeholder for other tabs
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Fixed Action Buttons Section
          Padding(
            padding: const EdgeInsets.all(16.0), // Apply padding here
            child: ActionButtonsSection(
              isChatEnabled: false, // Set to true when chat should be enabled
              onChatPressed: () {
                // Handle chat button press
                print('Chat button pressed');
              },
              onRequestTripPressed: () {
                context.push('/self-plan-setup?fromPlanner=true');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeaderSection extends StatelessWidget {
  final TripPlanner planner;

  const ProfileHeaderSection({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image
        SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
            child: planner.imagePath != null && planner.imagePath!.endsWith('.svg')
                ? SvgPicture.asset(
                    planner.imagePath!,
                    fit: BoxFit.cover,
                  )
                : planner.imagePath != null
                    ? Image.asset(
                        planner.imagePath!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.person, color: Colors.grey[600], size: 30),
                      ),
          ),
        ),

        const SizedBox(width: 12),

        // Name, Rating, and Location
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name with Verified Badge
              Row(
                children: [
                  Text(
                    planner.name,
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  if (planner.isVerified) ...[
                    const SizedBox(width: 6),
                    SvgPicture.asset(
                      'assets/images/Trips/Verified_Check.svg',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ],
              ),

              const SizedBox(height: 8),

              // Rating and Location
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    planner.rating.toString(),
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '(${planner.reviews} Reviews)',
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFF6B7280),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      planner.location,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StatsSection extends StatelessWidget {
  final TripPlanner planner;

  const StatsSection({Key? key, required this.planner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Trips Planned
        Expanded(
          child: Column(
            children: [
              Text(
                planner.tripsPlanned.toString(),
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Trips Planned',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),

        // Vertical Divider
        Container(
          width: 1,
          height: 40,
          color: const Color(0xFFE5E7EB),
        ),

        // Rate
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '\u0024${planner.price}',
                    style: const TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'per trip',
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Rate',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),

        // Vertical Divider
        Container(
          width: 1,
          height: 40,
          color: const Color(0xFFE5E7EB),
        ),

        // Response Time
        Expanded(
          child: Column(
            children: [
              Text(
                '< ${planner.responseTime}',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Response Time',
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileTabNavigation extends ConsumerWidget {
  const ProfileTabNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedProfileTabProvider);

    final tabs = ['Overview', 'Trips Planned', 'Reviews'];

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFF3F4F6),
      ),
      child: Row(
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                ref.read(selectedProfileTabProvider.notifier).state = tab;
              },
              child: Container(
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: const Color(0xFF3B82F6), width: 1)
                      : null,
                  color: isSelected ? const Color(0xFFEFF6FF) : Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    tab,
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF111827)
                          : const Color(0xFF6B7280),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
