import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/views/Trips_screen/Upcoming_trip.dart';
import 'package:tripitify/views/home_screens/buttom_nav.dart';
import 'package:tripitify/views/Explore_screen/Explore_screen.dart';
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
import '../Booking/bookings.dart';
import '../../widgets/home_widgets/experiences_card.dart';
import '../../widgets/home_widgets/community.dart';

//find the models and widgets that make up this homescreen in the /lib/widget and lib/models




import 'package:tripitify/controllers/home_controller.dart';

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
    const DiscoverDestinationScreen(),
    const TripPage(),
    const BookingPage(),
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
    final homeState = ref.watch(homeControllerProvider);
    final destinations = homeState.destinations;
    final upcomingTrips = homeState.upcomingTrips;
    final userName = homeState.userName;
    final currentTrip = homeState.currentTrip;
    final experiences = homeState.experiences;

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

              ExperiencesSection(experiences: experiences),
              const SizedBox(height: 32),
              // Quick Tip Section
              const QuickTipSection(),

              const SizedBox(height: 32),

              const CommunityHighlightWidget(),

              ],
          ),
        ),
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
