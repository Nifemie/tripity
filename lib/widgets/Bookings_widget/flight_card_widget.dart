import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';


// ==================== MODELS ====================

class FlightCard {
  final String id;
  final String airlineName;
  final String airlineLogoUrl;
  final double rating;
  final String departureCode;
  final String departureCity;
  final String arrivalCode;
  final String arrivalCity;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final List<String> tags; // e.g., ['Economy', 'Non-stop', '1 checked-bag']
  final double price;
  final VoidCallback? onTap;

  const FlightCard({
    required this.id,
    required this.airlineName,
    required this.airlineLogoUrl,
    required this.rating,
    required this.departureCode,
    required this.departureCity,
    required this.arrivalCode,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.tags,
    required this.price,
    this.onTap,
  });
}

// ==================== RIVERPOD PROVIDERS ====================

// Provider for selected flight
final selectedFlightProvider = StateProvider<String?>((ref) => null);

// Provider for flights list
final flightsProvider = Provider<List<FlightCard>>((ref) {
  return [
    FlightCard(
      id: 'flight_1',
      airlineName: 'Delta Airlines',
      airlineLogoUrl: 'assets/images/Bookings/Delta.png',
      rating: 4.6,
      departureCode: 'MXP',
      departureCity: 'MILAN',
      arrivalCode: 'JFK',
      arrivalCity: 'NEW YORK',
      departureTime: '10:15 AM',
      arrivalTime: '8:00 PM',
      duration: '9h 55m',
      tags: ['Economy', 'Non-stop', '1 checked-bag'],
      price: 749.0,
    ),
    FlightCard(
      id: 'flight_2',
      airlineName: 'United Airlines',
      airlineLogoUrl: 'assets/images/Bookings/Delta.png',
      rating: 4.4,
      departureCode: 'MXP',
      departureCity: 'MILAN',
      arrivalCode: 'JFK',
      arrivalCity: 'NEW YORK',
      departureTime: '11:30 AM',
      arrivalTime: '9:15 PM',
      duration: '9h 45m',
      tags: ['Business', 'Non-stop', '2 checked-bags'],
      price: 1200.0,
    ),
  ];
});

// ==================== AIRLINE HEADER ====================

class AirlineHeader extends StatelessWidget {
  final String airlineName;
  final String airlineLogoUrl;
  final double rating;

  const AirlineHeader({
    Key? key,
    required this.airlineName,
    required this.airlineLogoUrl,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left: Logo and Airline Info
        Row(
          children: [
            // Logo Container
            Container(
              width: 44,
              height: 44,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(44),
                child: Image.asset(
                  airlineLogoUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Airline Name and Rating
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Airline Name
                Text(
                  airlineName,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                // Rating
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/explore/Star.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFCD34D),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Right: Heart Icon
        GestureDetector(
          onTap: () {
            // Handle favorite
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff3F4F6),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 16,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== ROUTE SECTION ====================

class RouteSection extends StatelessWidget {
  final String departureCode;
  final String departureCity;
  final String arrivalCode;
  final String arrivalCity;

  const RouteSection({
    Key? key,
    required this.departureCode,
    required this.departureCity,
    required this.arrivalCode,
    required this.arrivalCity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Route Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Departure
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  departureCode,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.43,
                  ),
                ),
                Text(
                  departureCity,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
            // Route Divider
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // White circle
                  SvgPicture.asset(
                    'assets/images/Bookings/white_circle.svg',
                    width: 8,
                    height: 8,
                  ),
                  const SizedBox(width: 8),
                  // Divider line
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Airplane icon
                  SvgPicture.asset(
                    'assets/images/Bookings/Transport_Plane.svg',
                    width: 16,
                    height: 16,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF6B7280),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Divider line
                  Expanded(
                    child: Container(
                      height: 1,
                      color: const Color(0xFFE5E7EB),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Blue circle
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                ],
              ),
            ),
            // Arrival
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  arrivalCode,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.43,
                  ),
                ),
                Text(
                  arrivalCity,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== TAGS ROW ====================

class TagsRow extends StatelessWidget {
  final List<String> tags;

  const TagsRow({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        tags.length,
            (index) {
          return Flexible(
            child: Container(
              margin: EdgeInsets.only(
                right: index < tags.length - 1 ? 8 : 0,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(
                  color: const Color(0xFFF3F4F6),
                  width: 1,
                ),
              ),
              child: Text(
                tags[index],
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================== TIME SECTION ====================

// ==================== TIME SECTION ====================

class TimeSection extends StatelessWidget {
  final String departureTime;
  final String arrivalTime;
  final String duration;

  const TimeSection({
    Key? key,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Departure Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Departure',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            Text(
              departureTime,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
                height: 1.43,
              ),
            ),
          ],
        ),

        const SizedBox(width: 12),

        // Horizontal Line
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
          ),
        ),

        const SizedBox(width: 12),

        // Duration Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9999),
            border: Border.all(
              color: const Color(0xFFF3F4F6),
              width: 1,
            ),
            color: const Color(0xFFF3F4F6),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                          'assets/images/explore/Clock.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF6B7280),
                            BlendMode.srcIn,
                          ),
                        ),
              const SizedBox(width: 4),
              Text(
                duration,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Horizontal Line
        Expanded(
          child: Container(
            height: 1,
            color: const Color(0xFFE5E7EB),
          ),
        ),

        const SizedBox(width: 12),

        // Arrival Time
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Arrival',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.5,
              ),
            ),
            Text(
              arrivalTime,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111827),
                height: 1.43,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ==================== PRICE SECTION ====================

class PriceSection extends StatelessWidget {
  final double price;

  const PriceSection({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '\$${price.toStringAsFixed(0)}',
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF111827),
            height: 1.5,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          '/person',
          style: const TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

// ==================== FLIGHT CARD WIDGET ====================

class FlightCard_Widget extends ConsumerWidget {
  final FlightCard flight;

  const FlightCard_Widget({
    Key? key,
    required this.flight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFlight = ref.watch(selectedFlightProvider);
    final isSelected = selectedFlight == flight.id;

    return GestureDetector(
      onTap: () {
        ref.read(selectedFlightProvider.notifier).state = flight.id;
        flight.onTap?.call();
        print('Selected flight: ${flight.airlineName}');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFF3F4F6),
            width: 1,
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF172554).withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Airline Header
            AirlineHeader(
              airlineName: flight.airlineName,
              airlineLogoUrl: flight.airlineLogoUrl,
              rating: flight.rating,
            ),
            const SizedBox(height: 24),

            // Route Section
            RouteSection(
              departureCode: flight.departureCode,
              departureCity: flight.departureCity,
              arrivalCode: flight.arrivalCode,
              arrivalCity: flight.arrivalCity,
            ),
            const SizedBox(height: 24),

            // Tags Row
            TagsRow(tags: flight.tags),
            const SizedBox(height: 24),

            // Time Section
            TimeSection(
              departureTime: flight.departureTime,
              arrivalTime: flight.arrivalTime,
              duration: flight.duration,
            ),
            const SizedBox(height: 24),

            // Price Section
            PriceSection(price: flight.price),
          ],
        ),
      ),
    );
  }
}

// ==================== FLIGHT CARDS HORIZONTAL SCROLL ====================

class FlightCardsScroll extends ConsumerWidget {
  const FlightCardsScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flights = ref.watch(flightsProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(
          flights.length,
              (index) {
            return Padding(
              padding: EdgeInsets.only(
                right: index < flights.length - 1 ? 16 : 0,
              ),
              child: FlightCard_Widget(flight: flights[index]),
            );
          },
        ),
      ),
    );
  }
}

// ==================== FLIGHT SECTION ====================

class FlightSection extends ConsumerWidget {
  final String title;
  final String? subtitle;

  const FlightSection({
    Key? key,
    this.title = 'Available Flights',
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Instrument Sans',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                  height: 1.4,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle!,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Flight Cards Scroll
        const FlightCardsScroll(),
      ],
    );
  }
}

// // ==================== USAGE EXAMPLE ====================
//
// class FlightCardExample extends ConsumerWidget {
//   const FlightCardExample({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final selectedFlight = ref.watch(selectedFlightProvider);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const SizedBox(height: 16),
//
//               // Flight Section
//               const FlightSection(
//                 title: 'Available Flights',
//                 subtitle: 'Select a flight to continue booking',
//               ),
//
//               const SizedBox(height: 24),
//
//               // Show selected flight feedback
//               if (selectedFlight != null)
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: const Color(0xFFEFF6FF),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text(
//                       'You selected: $selectedFlight',
//                       style: const TextStyle(
//                         fontFamily: 'Instrument Sans',
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Color(0xFF3B82F6),
//                       ),
//                     ),
//                   ),
//                 ),
//
//               const SizedBox(height: 24),
//
//               // Buttons Section (Primary, Secondary, FullWidth)
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     // Primary Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF3B82F6),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text(
//                           'Continue',
//                           style: TextStyle(
//                             fontFamily: 'Instrument Sans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//
//                     // Secondary Button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 48,
//                       child: OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(
//                             color: Color(0xFFF3F4F6),
//                             width: 1,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         onPressed: () {},
//                         child: const Text(
//                           'Save for later',
//                           style: TextStyle(
//                             fontFamily: 'Instrument Sans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF111827),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }