import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart';
import 'package:tripitify/views/Trips_screen/plan_trip/trip_Planner/plannerProfile.dart';
import 'package:tripitify/widgets/home_widgets/trip_planner_card.dart';

// State provider for selected filter
final selectedFilterProvider = StateProvider<String>((ref) => 'All Planners');

// State provider for search text
final searchTextProvider = StateProvider<String>((ref) => '');

class TripPlannersScreen extends ConsumerWidget {
  const TripPlannersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dummy data for trip planners
    final List<TripPlanner> planners = [
      TripPlanner(
        name: 'Joseph Fubara',
        isVerified: true,
        rating: 4.9,
        reviews: 120,
        location: 'Lagos, Nigeria',
        specialties: ['Adventure', 'Nature', 'Photography'],
        tripsPlanned: 89,
        responseTime: '2 hours',
        isAcceptingClients: true,
        price: 250,
        imagePath: 'assets/images/Trips/joseph.png',
        about:
            'Passionate about creating unforgettable African experiences. Specializing in wildlife safaris and cultural immersion.',
        experience: '5+ years',
        destinationSpecialties: [
          'Lagos, Nigeria',
          'Nairobi, Kenya',
          'Cape Town, South Africa'
        ],
        travelExpertise: [
          'Wildlife Safari',
          'Cultural Immersion',
          'Adventure Travel'
        ],
        languages: ['English', 'Yoruba'],
      ),
      TripPlanner(
        name: 'Maria Rodriguez',
        isVerified: false,
        rating: 4.8,
        reviews: 95,
        location: 'Madrid, Spain',
        specialties: ['Culture', 'History', 'Food'],
        tripsPlanned: 120,
        responseTime: '4 hours',
        isAcceptingClients: true,
        price: 300,
        imagePath: 'assets/images/Trips/maria.png',
        about:
            'Explorer of historic cities and culinary delights. I design trips that feed your curiosity and your stomach.',
        experience: '4 years',
        destinationSpecialties: [
          'Madrid, Spain',
          'Rome, Italy',
          'Lisbon, Portugal'
        ],
        travelExpertise: ['Historical Tours', 'Culinary Trips', 'City Breaks'],
        languages: ['Spanish', 'English', 'Italian'],
      ),
      TripPlanner(
        name: 'Sarah Williams',
        isVerified: true,
        rating: 4.7,
        reviews: 88,
        location: 'London, UK',
        specialties: ['Luxury', 'Shopping', 'Art'],
        tripsPlanned: 75,
        responseTime: '3 hours',
        isAcceptingClients: false,
        price: 400,
        imagePath: 'assets/images/Trips/sarah.png',
        about:
            'Curator of bespoke luxury travel. From exclusive shopping trips to private art viewings, I create refined itineraries.',
        experience: '6 years',
        destinationSpecialties: ['London, UK', 'Paris, France', 'Milan, Italy'],
        travelExpertise: [
          'Luxury Travel',
          'Fashion & Shopping',
          'Art & Culture'
        ],
        languages: ['English', 'French'],
      ),
      TripPlanner(
        name: 'Christian Ford',
        isVerified: false,
        rating: 4.6,
        reviews: 70,
        location: 'New York, USA',
        specialties: ['Business', 'Nightlife'],
        tripsPlanned: 100,
        responseTime: '1 hour',
        isAcceptingClients: true,
        price: 350,
        imagePath: 'assets/images/Trips/christian.png',
        about:
            'Your guide to the city that never sleeps. I specialize in business travel with a side of vibrant nightlife.',
        experience: '3 years',
        destinationSpecialties: ['New York, USA', 'Las Vegas, USA'],
        travelExpertise: ['Business Travel', 'Nightlife', 'Entertainment'],
        languages: ['English'],
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar that doesn't change color on scroll
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            scrolledUnderElevation: 0,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFF111827)),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Trip Planners',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1.375,
              ),
            ),
            centerTitle: true,
          ),

          // Content below app bar
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                // Search Bar
                const SearchBarWidget(),
                const SizedBox(height: 16),
                // Filter Tabs
                const FilterTabsWidget(),
                const SizedBox(height: 20),
                ListView.separated(
                  padding: const EdgeInsets.only(
                      bottom: 20), // Add some padding at the bottom
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: planners.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final planner = planners[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TripPlannerProfileScreen(planner: planner),
                            ),
                          );
                        },
                        child: TripPlannerCard(planner: planner),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBarWidget extends ConsumerWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchText = ref.watch(searchTextProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 16, top: 8, bottom: 8),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xFF6B7280),
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    ref.read(searchTextProvider.notifier).state = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Paris, France',
                    hintStyle: TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  style: const TextStyle(
                    color: Color(0xFF111827),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
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

class FilterTabsWidget extends ConsumerWidget {
  const FilterTabsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedFilterProvider);

    final filters = [
      {'label': 'All Planners', 'count': 4},
      {'label': 'Available Now', 'count': 3},
      {'label': 'Top Rated', 'count': 4},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final label = filter['label'] as String;
          final count = filter['count'] as int;
          final isSelected = selectedFilter == label;

          return FilterChip(
            label: label,
            count: count,
            isSelected: isSelected,
            onTap: () {
              ref.read(selectedFilterProvider.notifier).state = label;
            },
          );
        },
      ),
    );
  }
}

class FilterChip extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({
    Key? key,
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEFF6FF) : const Color(0xFFF3F4F6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            '$label ($count)',
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF3B82F6)
                  : const Color(0xFF111827),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
