import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/views/home_screens/buttom_nav.dart';
import 'package:tripitify/views/home_screens/search_screen.dart';

// Models
class LocationState {
  final String location;
  final bool isLoading;
  final String? error;

  const LocationState({
    required this.location,
    required this.isLoading,
    this.error,
  });

  LocationState copyWith({
    String? location,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class Trip {
  final String destination;
  final String country;
  final DateTime startDate;
  final DateTime endDate;
  final int daysUntilStart;

  const Trip({
    required this.destination,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.daysUntilStart,
  });
}

class Destination {
  final String name;
  final String description;
  final String rating;
  final String country;
  final String duration;
  final String price;
  final List<String> tags;
  final String temperature;
  final bool hasImage;
  final String? imagePath;

  const Destination({
    required this.name,
    required this.description,
    required this.rating,
    required this.country,
    required this.duration,
    required this.price,
    required this.tags,
    required this.temperature,
    required this.hasImage,
    this.imagePath,
  });
}

class UpcomingTrip {
  final String title;
  final String status;
  final String location;
  final String dates;
  final String type;
  final String price;
  final String planner;
  final String? imagePath;

  const UpcomingTrip({
    required this.title,
    required this.status,
    required this.location,
    required this.dates,
    required this.type,
    required this.price,
    required this.planner,
    this.imagePath,
  });
}

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

  void _onNavigationTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationState = ref.watch(locationProvider);
    final currentTrip = ref.watch(currentTripProvider);
    final destinations = ref.watch(destinationsProvider);
    final upcomingTrips = ref.watch(upcomingTripsProvider);
    final userName = ref.watch(userNameProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Location, Notification, and Traveller
              _buildTopBar(context, ref, locationState),

              const SizedBox(height: 20),

              // Welcome Banner
              _buildWelcomeBanner(userName),

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
              _buildQuickActionsGrid(),

              const SizedBox(height: 24),

              // Trip Countdown Card
              _buildTripCountdownCard(currentTrip),

              const SizedBox(height: 32),

              // Popular Destinations Section
              _buildPopularDestinationsSection(destinations),

              const SizedBox(height: 32),

              // Upcoming Trips Section
              _buildUpcomingTripsSection(upcomingTrips),

              const SizedBox(height: 32),

              // Quick Tip Section
              _buildQuickTipSection(),

              const SizedBox(height: 32),

              // Trip Planner Section
              _buildTripPlannerSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationComponent(
        currentIndex: _currentIndex,
        onTap: _onNavigationTap,
      ),
    );
  }

  Widget _buildQuickTipSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFEFF6FF), // Primary Blue 50
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick Tip Header
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  size: 12,
                  color: Colors.blue.shade600,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                "Quick Tip",
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tip Content
          const Text(
            "Book flights on Tuesday afternoons for the best deals. Airlines often release discounts on Monday evenings, and competitors match prices by Tuesday.",
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4B5563),
              // Text Secondary
              height: 1.5, // 150% line height
            ),
          ),

          const SizedBox(height: 16),

          // View More Button
          Container(
            width: double.infinity,
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9999),
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                "View More",
                style: TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2563EB),
                  // Text Link
                  height: 1.25, // 125% line height
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripPlannerSection() {
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
        _buildTripPlannerCard(
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

        const SizedBox(height: 12),

        _buildTripPlannerCard(
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
      ],
    );
  }

  Widget _buildTripPlannerCard({
    required String name,
    required double rating,
    required int reviews,
    required String location,
    required List<String> specialties,
    required int tripsPlanned,
    required String responseTime,
    required int price,
    required bool isVerified,
    required bool isAcceptingClients,
    String? imagePath,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image - Updated styling
              Container(
                width: 44, // width: 44px
                height: 44, // height: 44px
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                  // border-radius: 44px
                  color: Colors.grey[300], // placeholder background
                  // You can replace this with:
                  // image: imagePath != null
                  //   ? DecorationImage(
                  //       image: AssetImage(imagePath),
                  //       fit: BoxFit.cover,
                  //     )
                  //   : null,
                ),
                child: imagePath == null
                    ? Icon(Icons.person, color: Colors.grey[600], size: 24)
                    : null,
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Verified Badge
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                            height: 1.5,
                          ),
                        ),
                        if (isVerified) ...[
                          const SizedBox(width: 4),
                          // Blue verification icon - you'll add your SVG here
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Colors.blue,
                              // Placeholder - replace with your blue verify SVG
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Rating and Reviews
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '($reviews Reviews)',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.location_on, color: Color(0xFF6B7280),
                            size: 16),
                        const SizedBox(width: 4),
                        Text(
                          location,
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Specialties
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: specialties.map((specialty) =>
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xFFF3F4F6),
                            ),
                            child: Text(
                              specialty,
                              style: const TextStyle(
                                fontFamily: 'Instrument Sans',
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF374151),
                              ),
                            ),
                          )).toList(),
                    ),

                    const SizedBox(height: 8),

                    // Trip Stats and Accepting Clients
                    Row(
                      children: [
                        Text(
                          '$tripsPlanned trips planned',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Responds in $responseTime',
                          style: const TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Accepting Clients Badge - Updated styling
                    if (isAcceptingClients)
                      Container(
                        padding: const EdgeInsets.all(4), // padding: 4px
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          // border-radius: var(--Border-Radius-full, 9999px)
                          color: const Color(
                              0xFFDCFCE7), // background: var(--Success-Green-100, #DCFCE7)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Green verification icon - you'll add your SVG here
                            Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Color(0xFF22C55E),
                                // Placeholder - replace with your green verify SVG
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // gap: 8px
                            const Text(
                              'Accepting Clients',
                              style: TextStyle(
                                color: Color(0xFF22C55E),
                                // color: var(--Success-Green-500, #22C55E)
                                fontFamily: 'Instrument Sans',
                                // font-family: var(--Font-Primary, "Instrument Sans")
                                fontSize: 12,
                                // font-size: var(--Font-Size-xs, 12px)
                                fontWeight: FontWeight.w400,
                                // font-weight: var(--Font-Weight-normal, 400)
                                height: 1.5, // line-height: 18px (150%)
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Bottom row with price aligned to the right
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '\$price per trip',
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),
        ],
      ),
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
              return _buildTripCard(trips[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTripCard(UpcomingTrip trip) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with image and title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip image
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                    image: trip.imagePath != null
                        ? DecorationImage(
                      image: AssetImage(trip.imagePath!),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: trip.imagePath == null
                      ? Icon(Icons.image, color: Colors.grey[600])
                      : null,
                ),

                const SizedBox(width: 12),

                // Title and status
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.title,
                        style: const TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9999),
                          color: trip.status == 'Confirmed'
                              ? const Color(0xFFDCFCE7)
                              : const Color(0xFFFEF3C7),
                        ),
                        child: Text(
                          trip.status,
                          style: TextStyle(
                            fontFamily: 'Instrument Sans',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: trip.status == 'Confirmed'
                                ? const Color(0xFF22C55E)
                                : const Color(0xFFF59E0B),
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Trip details
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.location,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.dates,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                Icon(
                  Icons.person,
                  size: 14,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  trip.type,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  trip.price,
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Planner and View Trip button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Planner",
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      trip.planner,
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF111827),
                      ),
                    ),
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    // Handle view trip
                    debugPrint("View trip: ${trip.title}");
                  },
                  child: Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9999),
                      color: const Color(0xFFF3F4F6),
                    ),
                    child: const Center(
                      child: Text(
                        "View Trip",
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, WidgetRef ref,
      LocationState locationState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Location Section
        Flexible(
          child: GestureDetector(
            onTap: () => ref.read(locationProvider.notifier).refreshLocation(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 4),
                locationState.isLoading
                    ? const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.blue,
                  ),
                )
                    : Flexible(
                  child: Text(
                    locationState.location,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
        ),

        // Right side: Notification and Traveller
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Notification Icon - Updated to use SVG
            GestureDetector(
              onTap: () {
                // Handle notifications
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications clicked!')),
                );
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: const Color(0xFFF3F4F6),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/Home/Bell_notification.svg',
                    // Replace with your SVG file path
                    width: 24, // Adjust icon size as needed
                    height: 24,
                    // You can add color if needed:
                    // colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 8),
            // Add some spacing between notification and traveller

            // Traveller Box
            Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                color: const Color(0xFFF3F4F6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Traveller",
                    style: TextStyle(
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeBanner(String userName) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/Home/morning2.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good morning, $userName!",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    height: 1.375,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "We are glad to have you back",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.wb_sunny,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return Column(
      children: [
        // First Row
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                iconPath: 'assets/images/Home/calender.svg',
                // Replace with your SVG path
                title: "Plan a Trip",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
                iconPath: 'assets/images/Home/user.svg',
                // Replace with your SVG path
                title: "Find Trip Planner",
                onTap: () {
                  Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
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
              child: _buildQuickActionCard(
                iconPath: 'assets/images/Home/plane.svg',
                // Replace with your SVG path
                title: "Book Flights",
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
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
              child: _buildQuickActionCard(
                iconPath: 'assets/images/Home/Dialog.svg',
                // Replace with your SVG path
                title: "TripTalk",
                onTap: () {},
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickActionCard(
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


  Widget _buildTripCountdownCard(Trip trip) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Days counter
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "STARTS IN",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${trip.daysUntilStart}",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "DAYS",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your ${trip.destination} trip starts in ${trip
                      .daysUntilStart} days",
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                        Icons.calendar_today, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text("Jul 27 - Jul 31, 2025",
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const SizedBox(width: 12),
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text("${trip.destination}, ${trip.country}",
                        style: const TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "It's time to start packing up your bag",
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
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
              return _buildDestinationCard(destinations[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(Destination destination) {
    return Container(
      width: 318,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.fromLTRB(12, 16, 16, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image Container
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFD3D3D3),
            ),
            child: Stack(
              children: [
                // Image or placeholder
                destination.hasImage && destination.imagePath != null
                    ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(destination.imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade300,
                        Colors.purple.shade300,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.image,
                          size: 48,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          destination.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Heart icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border,
                      size: 18,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Destination Name
          Text(
            destination.name,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.2,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          Text(
            destination.description,
            style: const TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF6B7280),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 16),

          // Location, Temperature, and Rating Row
          Row(
            children: [
              // Location
              const Icon(
                Icons.location_on,
                size: 16,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Text(
                destination.country,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),

              const SizedBox(width: 16),

              // Temperature
              const Icon(
                Icons.wb_sunny,
                size: 16,
                color: Colors.orange,
              ),
              const SizedBox(width: 4),
              Text(
                destination.temperature,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                ),
              ),

              const Spacer(),

              // Rating
              const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
              const SizedBox(width: 4),
              Text(
                destination.rating,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Tags
          if (destination.tags.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: destination.tags.take(3).map<Widget>((tag) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              )).toList(),
            ),

          const SizedBox(height: 16),

          // Plan a Trip Button
          Container(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
                onPressed: () {
                  // Add your navigation or action here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.04, -1.0),
                      end: Alignment(1.07, 1.0),
                      colors: [
                        Color(0xFF3B82F6), // Primary Blue 500
                        Color(0xFF2563EB), // Primary Blue 600
                        Color(0xFF1E40AF), // Primary Blue 800
                      ],
                      stops: [0.0, 0.51, 1.07],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(9999)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add your calendar icon here
                      // Icon(Icons.calendar_today, size: 16, color: Colors.white),
                      // SizedBox(width: 8),
                      Text(
                        "Plan a Trip Here",
                        style: TextStyle(
                          fontFamily: 'Instrument Sans',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  Widget _buildQuickActionCard({
    required String iconPath, // Changed from IconData to String for SVG path
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFFF3F4F6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      iconPath,
                      width: 18,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        Colors.black87,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/images/Home/ArrowRightUp.svg',
                  // Replace with your arrow SVG path
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(
                    Colors.grey[400]!,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}