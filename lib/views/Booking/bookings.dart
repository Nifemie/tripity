import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/Bookings_widget/search_widget.dart';
import '../../widgets/Bookings_widget/category_widget.dart';
import '../../widgets/Bookings_widget/flight_card_widget.dart';
import '../../widgets/Bookings_widget/hotel_card_widget.dart';


class BookingPage extends ConsumerWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            _buildAppBar(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Search Bar Section
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: ResponsiveSearchBar(),
                    ),

                    const SizedBox(height: 24),

                    // Category Section
                    const CategorySection(),

                    const SizedBox(height: 32),

                    // Flight Section
                    const FlightSection(
                      title: 'Ready to take off?',
                      subtitle: 'Since you explored New York City, here are top flight deals from Milan.',
                    ),

                    const SizedBox(height: 32),

                    // Hotel Section
                    const HotelSection(
                      title: 'Stay in the heart of the city that never sleeps',
                      subtitle: 'Based on your interest in New York City, these stays are trending right now..',
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Title
          const Text(
            'Booking',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.33,
            ),
          ),

          // Cart Icon
          GestureDetector(
            onTap: () {
              // Handle cart tap
              print('Cart tapped');
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/Bookings/cart2.svg',
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF111827),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// // ==================== ALTERNATIVE WITH SECTION HEADERS ====================
//
// class BookingPageWithHeaders extends ConsumerWidget {
//   const BookingPageWithHeaders({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // App Bar
//             _buildAppBar(context),
//
//             // Scrollable Content
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 16),
//
//                     // Search Bar Section
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'What are you looking for?',
//                             style: TextStyle(
//                               fontFamily: 'Instrument Sans',
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF111827),
//                               height: 1.4,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             'Search for flights, stays, experiences & more. Get tailored options.',
//                             style: TextStyle(
//                               fontFamily: 'Instrument Sans',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                               color: Color(0xFF6B7280),
//                               height: 1.5,
//                             ),
//                           ),
//                           const SizedBox(height: 16),
//                           const ResponsiveSearchBar(),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Category Section
//                     const CategorySection(),
//
//                     const SizedBox(height: 32),
//
//                     // Flight Section
//                     const FlightSection(
//                       title: 'Ready to take off?',
//                       subtitle: 'Book your next adventure with Delta, JFK, CXI, and so on. Flight cards are here to get you started.',
//                     ),
//
//                     const SizedBox(height: 32),
//
//                     // Hotel Section
//                     const HotelSection(
//                       title: 'Why is the place (that rhymes stays)',
//                       subtitle: 'Based on your interest in New York. These options are curated for you.',
//                     ),
//
//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAppBar(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // Title
//           const Text(
//             'Booking',
//             style: TextStyle(
//               fontFamily: 'Instrument Sans',
//               fontSize: 24,
//               fontWeight: FontWeight.w600,
//               color: Color(0xFF111827),
//               height: 1.33,
//             ),
//           ),
//
//           // Cart Icon
//           GestureDetector(
//             onTap: () {
//               // Handle cart tap
//               print('Cart tapped');
//             },
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3F4F6),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: SvgPicture.asset(
//                   'assets/images/Bookings/cart.svg',
//                   width: 20,
//                   height: 20,
//                   colorFilter: const ColorFilter.mode(
//                     Color(0xFF111827),
//                     BlendMode.srcIn,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

