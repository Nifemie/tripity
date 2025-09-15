import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tripitify/models/home_screen/destination.dart';
import 'package:tripitify/models/home_screen/trip.dart';
import 'package:tripitify/models/home_screen/upcoming_trip.dart';
import 'package:tripitify/models/home_screen/location_state.dart';
import 'package:tripitify/models/home_screen/experience.dart';

// 1. Define the State class
class HomeState {
  final LocationState locationState;
  final String userName;
  final Trip currentTrip;
  final List<Destination> destinations;
  final List<UpcomingTrip> upcomingTrips;
  final List<Experience> experiences;
  final bool isLoading;

  HomeState({
    this.locationState = const LocationState(location: "Loading location...", isLoading: true),
    this.userName = "",
    Trip? currentTrip,
    this.destinations = const [],
    this.upcomingTrips = const [],
    this.experiences = const [],
    this.isLoading = true,
  }) : currentTrip = currentTrip ?? Trip(destination: "", country: "", startDate: DateTime.now(), endDate: DateTime.now(), daysUntilStart: 0);

  HomeState copyWith({
    LocationState? locationState,
    String? userName,
    Trip? currentTrip,
    List<Destination>? destinations,
    List<UpcomingTrip>? upcomingTrips,
    List<Experience>? experiences,
    bool? isLoading,
  }) {
    return HomeState(
      locationState: locationState ?? this.locationState,
      userName: userName ?? this.userName,
      currentTrip: currentTrip ?? this.currentTrip,
      destinations: destinations ?? this.destinations,
      upcomingTrips: upcomingTrips ?? this.upcomingTrips,
      experiences: experiences ?? this.experiences,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// 2. Define the Controller (StateNotifier)
class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState()) {
    _initialize();
  }

  Future<void> _initialize() async {
    state = state.copyWith(isLoading: true);
    await _getCurrentLocation();
    _loadData();
    state = state.copyWith(isLoading: false);
  }

  void _loadData() {
    final now = DateTime.now();
    final tripStart = DateTime(2025, 7, 27);
    final daysUntil = tripStart.difference(now).inDays;

    state = state.copyWith(
      userName: "Benjamin",
      currentTrip: Trip(
        destination: "Paris",
        country: "France",
        startDate: DateTime(2025, 7, 27),
        endDate: DateTime(2025, 7, 31),
        daysUntilStart: daysUntil > 0 ? daysUntil : 5,
      ),
      destinations: [
        const Destination(
          name: 'Santorini',
          description: 'Great for stunning sunsets and romantic getaways',
          rating: '4.8',
          country: 'Greece',
          duration: '5-7 Days',
          price: '\$1,200',
          tags: ['Nature', 'Romance', 'Culture' '+1'],
          temperature: 'Sunny 29°C',
          hasImage: true,
          imagePath: 'assets/images/Home/santorini.jpg',
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
      ],
      upcomingTrips: [
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
      ],
      experiences: [
        const Experience(
          imagePath: 'assets/images/Home/luxury.png', // Placeholder
          title: 'Luxury Santorini Resort',
          rating: 4.8,
          description: 'Ocean-view suites with infinity pools & breakfast include...',
          location: 'Imerovigli, Santorini',
          reviewCount: 1492,
          distance: '1 km from Oia',
          tags: ['Spa & Wellness', 'Infinity Pool', 'Couples', 'Luxury'],
          price: 720,
        ),
        const Experience(
          imagePath: 'assets/images/Home/city2.jpg', // Placeholder
          title: 'Tokyo Grand Hotel',
          rating: 4.9,
          description: 'Modern rooms with stunning city views & top amenities.',
          location: 'Shinjuku, Tokyo',
          reviewCount: 2105,
          distance: '500m from Station',
          tags: ['Free Wifi', 'Restaurant', 'Business'],
          price: 550,
        ),
      ]
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(locationState: state.locationState.copyWith(location: "Location services disabled", isLoading: false, error: "Location services are disabled"));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(locationState: state.locationState.copyWith(location: "Location permission denied", isLoading: false, error: "Location permission denied"));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(locationState: state.locationState.copyWith(location: "Location permission permanently denied", isLoading: false, error: "Location permission permanently denied"));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        state = state.copyWith(locationState: state.locationState.copyWith(location: "${place.locality}, ${place.country}", isLoading: false, error: null));
      }
    } catch (e) {
      state = state.copyWith(locationState: state.locationState.copyWith(location: "Unable to get location", isLoading: false, error: e.toString()));
    }
  }

  void refreshLocation() {
    state = state.copyWith(locationState: state.locationState.copyWith(isLoading: true));
    _getCurrentLocation();
  }
}

// 3. Define the Provider
final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController();
});
