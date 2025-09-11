import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/views/Trips_screen/Upcoming_trip.dart';
import 'package:tripitify/views/home_screens/buttom_nav.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/home_widgets/quick_action_card.dart';
import 'package:tripitify/models/home_screen/destination.dart';
import 'package:tripitify/widgets/home_widgets/destination_card.dart';
import 'package:tripitify/models/home_screen/trip.dart';
import 'package:tripitify/widgets/home_widgets/trip_countdown_card.dart';
import 'package:tripitify/models/home_screen/upcoming_trip.dart';
import 'package:tripitify/widgets/home_widgets/trip_card.dart';
import 'package:tripitify/models/home_screen/trip_planner.dart';
import 'package:tripitify/widgets/home_widgets/trip_planner_card.dart';
import 'package:tripitify/widgets/home_widgets/welcome_banner.dart';
import 'package:tripitify/widgets/home_widgets/quick_tip_section.dart';
import 'package:tripitify/models/home_screen/location_state.dart';
import 'package:tripitify/widgets/home_widgets/top_bar.dart';
import '../Trips_screen/Trip_screen.dart';

//find the models and widgets that make up this homescreen in the /lib/widget and lib/models




// Location State Notifier
class LocationNotifier extends StateNotifier<LocationState> {
  LocationNotifier() : super(const LocationState(location: "Loading location...", isLoading: true)) {
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(
          location: "Location services disabled",
          isLoading: false,
          error: "Location services are disabled",
        );
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(
            location: "Location permission denied",
            isLoading: false,
            error: "Location permission denied",
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          location: "Location permission permanently denied",
          isLoading: false,
          error: "Location permission permanently denied",
        );
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        state = state.copyWith(
          location: "${place.locality}, ${place.country}",
          isLoading: false,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(
        location: "Unable to get location",
        isLoading: false,
        error: e.toString(),
      );
      debugPrint("Error getting location: $e");
    }
  }

  void refreshLocation() {
    state = state.copyWith(isLoading: true);
    _getCurrentLocation();
  }
}

// Providers
final locationProvider = StateNotifierProvider<LocationNotifier, LocationState>((ref) {
  return LocationNotifier();
});

final currentTripProvider = Provider<Trip>((ref) {
  final now = DateTime.now();
  final tripStart = DateTime(2025, 7, 27);
  final daysUntil = tripStart.difference(now).inDays;

  return Trip(
    destination: "Paris",
    country: "France",
    startDate: DateTime(2025, 7, 27),
    endDate: DateTime(2025, 7, 31),
    daysUntilStart: daysUntil > 0 ? daysUntil : 5, // Fallback to 5 for demo
  );
});

final destinationsProvider = Provider<List<Destination>>((ref) {
  return [
    const Destination(
      name: 'Santorini',
      description: 'Great for stunning sunsets and romantic getaways',
      rating: '4.8',
      country: 'Greece',
      duration: '5-7 Days',
      price: '\$1,200',
      tags: ['Nature', 'Romance', 'Culture'],
      temperature: 'Sunny 29°C',
      hasImage: true,
      imagePath: 'assets/images/Home/city1.png',
    ),
    const Destination(
      name: 'Kyoto',
      description: 'Perfect for cultural immersion and temple exploration',
      rating: '4.9',
      country: 'Japan',
      duration: '4-6 Days',
      price: '\$1,800',
      tags: ['Culture', 'History', 'Temple'],
      temperature: 'Mild 24°C',
      hasImage: true,
      imagePath: 'assets/images/Home/city2.jpg',
    ),
    const Destination(
      name: 'Bali',
      description: 'Amazing beaches and tropical paradise',
      rating: '4.7',
      country: 'Indonesia',
      duration: '6-8 Days',
      price: '\$900',
      tags: ['Beach', 'Nature', 'Tropical'],
      temperature: 'Warm 28°C',
      hasImage: false,
    ),
  ];
});

final upcomingTripsProvider = Provider<List<UpcomingTrip>>((ref) {
  return [
    const UpcomingTrip(
      title: '5 Days in Cape Town',
      status: 'Confirmed',
      location: 'Cape Town, South Africa',
      dates: 'Jul 27 - Jul 31, 2025',
      type: 'Solo',
      price: '\$1800',
      planner: 'Joseph Fubara',
      imagePath: 'assets/images/Home/capetown.png',
    ),
    const UpcomingTrip(
      title: 'Quick Trip',
      status: 'Pending',
      location: 'Bali, Indonesia',
      dates: 'Aug 15 - Aug 20, 2025',
      type: 'Family',
      price: '\$2400',
      planner: 'Sarah Chen',
      imagePath: 'assets/images/Home/bali.png',
    ),
  ];
});

final userNameProvider = Provider<String>((ref) => "Benjamin");

// Main HomeScreen Widget (now ConsumerStatefulWidget)
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTabPage(),
    const Center(child: Text('Explore')),
    const TripPage(),
    const Center(child: Text('Booking')),
    const Center(child: Text('More')),
  ];

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationComponent(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }
}

class HomeTabPage extends ConsumerWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinations = ref.watch(destinationsProvider);
    final upcomingTrips = ref.watch(upcomingTripsProvider);
    final userName = ref.watch(userNameProvider);
    final currentTrip = ref.watch(currentTripProvider);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Location, Notification, and Traveller
              const TopBar(),

              const SizedBox(height: 20),

              // Welcome Banner
              WelcomeBanner(userName: userName),

              const SizedBox(height: 24),

              // Quick Actions Title
              const Text(
                "Quick Actions",
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              // Quick Actions Grid
              _buildQuickActionsGrid(context),

              const SizedBox(height: 24),

              // Trip Countdown Card
              TripCountdownCard(trip: currentTrip),

              const SizedBox(height: 32),

              // Popular Destinations Section
              _buildPopularDestinationsSection(destinations),

              const SizedBox(height: 32),

              // Upcoming Trips Section
              _buildUpcomingTripsSection(upcomingTrips),

              const SizedBox(height: 32),

              // Quick Tip Section
              const QuickTipSection(),

              const SizedBox(height: 32),

              // Trip Planner Section
              _buildTripPlannerSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTripPlannerSection() {
    final tripPlanners = [
      const TripPlanner(
        name: "Joseph Fubara",
        rating: 4.9,
        reviews: 127,
        location: "Paris, France",
        specialties: ["Romantic", "Wellness & Relaxation"],
        tripsPlanned: 54,
        responseTime: "< 1 hours",
        price: 75,
        isVerified: true,
        isAcceptingClients: true,
        imagePath: 'assets/images/Home/Ellipse.svg',
      ),
      const TripPlanner(
        name: "Maria Rodriguez",
        rating: 4.8,
        reviews: 87,
        location: "Barcelona, Spain",
        specialties: ["Nature", "Photography", "Culture & History"],
        tripsPlanned: 89,
        responseTime: "< 2 hours",
        price: 60,
        isVerified: true,
        isAcceptingClients: true,
        imagePath: null,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        const Text(
          "Find a Trip Planner",
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111827),
            // Text Primary
            height: 1.5, // 150% line height
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Connect with certified travel experts",
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            // Text Tertiary
            height: 1.5, // 150% line height
          ),
        ),

        const SizedBox(height: 16),

        // Search Bar - Updated styling
        Container(
          height: 52,
          padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // var(--Border-Radius-xl, 12px)
            color: const Color(0xFFF9FAFB), // var(--Neutral-Gray-50, #F9FAFB)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Search Icon
              Icon(
                Icons.search,
                size: 20,
                color: Colors.grey[400],
              ),
              const SizedBox(width: 8), // gap: 8px
              const Expanded(
                child: Text(
                  "Search by destination or specialties...",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    // Text Tertiary
                    height: 1.5, // 150% line height
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Trip Planners List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tripPlanners.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return TripPlannerCard(planner: tripPlanners[index]);
          },
        ),
      ],
    );
  }

  Widget _buildUpcomingTripsSection(List<UpcomingTrip> trips) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Upcoming Trips",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "2 trips planned",
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
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF6B7280),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Horizontal Scrollable Trip Cards
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: trips.length,
            padding: const EdgeInsets.only(right: 16),
            itemBuilder: (context, index) {
              return TripCard(trip: trips[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context) {
    return Column(
      children: [
        // First Row
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/calender.svg',
                // Replace with your SVG path
                title: "Plan a Trip",
                onTap: () {
                  context.push('/search');
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/user.svg',
                // Replace with your SVG path
                title: "Find Trip Planner",
                onTap: () {
                  context.push('/search');
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Second Row
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/plane.svg',
                // Replace with your SVG path
                title: "Book Flights",
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/Home.svg',
                // Replace with your SVG path
                title: "Find Accommodation",
                onTap: () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Third Row (New)
        Row(
          children: [
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/Dialog.svg',
                // Replace with your SVG path
                title: "TripTalk",
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: QuickActionCard(
                iconPath: 'assets/images/Home/Lightbulb.svg',
                // Replace with your SVG path
                title: "Travel Tips",
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPopularDestinationsSection(List<Destination> destinations) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recommended for You",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Destinations that match your travel interests and style.",
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
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Color(0xFF6B7280),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Horizontal Scrollable Destinations
        SizedBox(
          height: 480,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            padding: const EdgeInsets.only(right: 16),
            itemBuilder: (context, index) {
              return DestinationCard(destination: destinations[index]);
            },
          ),
        ),
      ],
    );
  }
}
