import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/views/Explore_screen/destination_screens/destinationDetails_screen.dart';
import 'package:tripitify/widgets/Explore_widgets/explore_widgets.dart';
import 'package:tripitify/widgets/home_widgets/destination_card.dart';
import 'package:tripitify/models/home_screen/destination.dart';
import 'package:tripitify/widgets/Explore_widgets/explore_header_section.dart';
import 'package:tripitify/widgets/Explore_widgets/Travel_trip_widget.dart';

// Providers for state management
final searchTextProvider = StateProvider<String>((ref) => '');
final selectedFilterProvider = StateProvider<String>((ref) => 'Popular');

class DiscoverDestinationScreen extends ConsumerWidget {
  const DiscoverDestinationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Destination> exploreDestinations = [
      Destination(
        name: 'New York City, USA',
        description: 'The city that never sleeps with iconic landmarks and vibrant culture',
        imagePath: 'assets/images/explore/USA.png',
        rating: '4.5',
        country: 'Dummy Country',
        duration: '5 days',
        price: '\$500',
        tags: ['Culture', 'Food & Cuisine', 'Photography', '+1'],
        temperature: '25°C',
        hasImage: true,
        travellersCount: 24,
      ),
      Destination(
        name: 'Santorini',
        description: 'Stunning sunsets and white-washed buildings overlooking the Aegean Sea',
        imagePath: 'assets/images/Home/satrorini.jpg',
        rating: '4.8',
        country: 'USA',
        duration: '10 days',
        price: '\$1200',
        tags: ['City Trip', 'Nature', 'Culture'],
        temperature: '20°C',
        hasImage: true,
        travellersCount: 32,
      ),
      // Add more destinations here if needed
    ];

    final List<Destination> popularDestinations = [
      Destination(
        name: 'Paris, France',
        description: 'The city of light awaits with its romantic atmosphere and world-class cuisine',
        imagePath: 'assets/images/explore/france.png',
        rating: '4.7',
        country: 'France',
        duration: '7 days',
        price: '\$900',
        tags: ['Culture', 'Romance', 'History'],
        temperature: '18°C',
        hasImage: true,
      ),
      Destination(
        name: 'Bali, Indonesia',
        description: 'A tropical paradise with beautiful beaches, lush rice paddies, and vibrant culture.',
        imagePath: 'assets/images/explore/bali.png',
        rating: '4.9',
        country: 'Indonesia',
        duration: '10 days',
        price: '\$1100',
        tags: ['Beach', 'Nature', 'Relaxation'],
        temperature: '28°C',
        hasImage: true,
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 15), // Added padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Destinations This Month',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  height: 1.375,
                ),
              ),
              Text(
                'Where Travellers Are Headed This Month',
                style: TextStyle(
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            

            const SizedBox(height: 24),

            // Search Input Field
            TextFormField(
              onChanged: (value) => ref.read(searchTextProvider.notifier).state = value,
              decoration: InputDecoration(
                hintText: 'Search destinations, interests, or experiences…',
                hintStyle: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/images/explore/search.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6B7280),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    'assets/images/explore/Microphone.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6B7280),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
              style: const TextStyle(
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Filter Chips (Horizontal Scrollable)
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  FilterChipWidget(
                    'Popular',
                    'assets/images/explore/Star.svg',
                  ),
                  const SizedBox(width: 8),
                  FilterChipWidget(
                    'Nearby',
                    'assets/images/Trips/Map_icon.svg',
                  ),
                  const SizedBox(width: 8),
                  FilterChipWidget(
                    'Trending',
                    'assets/images/explore/trending.svg',
                  ),
                  const SizedBox(width: 8),
                  FilterChipWidget(
                    'Weather',
                    'assets/images/explore/Temperature.svg',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Explore by Interest Section
            const Text(
              'Explore by Interest',
              style: TextStyle(
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Interest Chips
            SizedBox(
              height: 44,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InterestChipWidget(
                    'Adventure',
                    'assets/images/account_setup/Bonfire.svg',
                  ),
                  const SizedBox(width: 8),
                  InterestChipWidget(
                    'Food',
                    'assets/images/account_setup/Chef Hat.svg',
                  ),
                  const SizedBox(width: 8),
                  InterestChipWidget(
                    'Photography',
                    'assets/images/account_setup/Camera.svg',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Explore by Continent Section
            const Text(
              'Explore by Continent',
              style: TextStyle(
                color: Color(0xFF111827),
                fontFamily: 'Instrument Sans',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 16),

            // Continent Cards
            Row(
              children: [
                Expanded(
                  child: ContinentCardWidget('Asia', '15 destinations'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ContinentCardWidget('Europe', '12 destinations'),
                ),
              ],
            ),

            const SizedBox(height: 24), // This is the SizedBox before the DestinationCards
            const SizedBox(height: 32), // Spacing before the new header
            ExploreHeaderSection(
              title: "Recommended for You",
              subtitle: "Handpicked for your interests",
              onViewAllTap: () {
                // Handle "View All" tap, e.g., navigate to a full list of destinations
                // context.push('/all-destinations');
              },
            ),
            const SizedBox(height: 20), // Spacing between header and cards
            SizedBox(
              height: 480, // Assuming a fixed height for the cards to be scrollable
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: exploreDestinations.length,
                padding: const EdgeInsets.only(right: 16), // Add padding to the end
                itemBuilder: (context, index) {
                  return DestinationCard(destination: exploreDestinations[index], showTravellersCount: true);
                },
              ),
            ),
            const SizedBox(height: 24),

            const SizedBox(height: 32), // Spacing before the new header
            ExploreHeaderSection(
              title: "Popular Destinations",
              subtitle: "Top places to explore around the world",
              onViewAllTap: () {
                // Handle "View All" tap
              },
            ),
            const SizedBox(height: 20), // Spacing between header and cards
            SizedBox(
              height: 480, // Assuming a fixed height for the cards to be scrollable
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularDestinations.length,
                padding: const EdgeInsets.only(right: 16), // Add padding to the end
                itemBuilder: (context, index) {
                  // Note: showTravellersCount is not passed, so it defaults to false
                  return DestinationCard(
                    destination: popularDestinations[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationDetailScreen(
                            imagePath: popularDestinations[index].imagePath ?? '',
                            destinationName: popularDestinations[index].name,
                            country: popularDestinations[index].country,
                            description: popularDestinations[index].description,
                            rating: double.parse(popularDestinations[index].rating),
                            aboutTitle: 'About ${popularDestinations[index].name.split(',').first}',
                            aboutDescription: popularDestinations[index].name == 'Paris, France'
                                ? 'Paris, the City of Light, has been a center of art, fashion, culture, and cuisine for centuries. Founded by the Parisii tribe around 250 BC, it became the capital of France in 508 AD. The city flourished during the Renaissance and became the European center of fashion and decorative arts during the 18th and 19th centuries.'
                                : popularDestinations[index].description,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 32),
            const TravelTipsWidget(),
            const SizedBox(height: 24),
          ],

        ),

      ),
    );
  }

  

  

  
}