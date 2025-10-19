import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/Bookings_widget/Transport_tab.dart';
import '../../widgets/Bookings_widget/flight_card_widget.dart';
import '../../widgets/Bookings_widget/custom_reusable_button.dart';
import 'package:flutter_svg/svg.dart';
// ==================== TRANSPORT PAGE ====================

class TransportPage extends ConsumerWidget {
  const TransportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTransportTabProvider);
    final flights = ref.watch(flightsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // leadingWidth: 30,
        titleSpacing: 0,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111827),
            size: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Transport',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.33,
          ),
        ),
        centerTitle: false,
        actions: [
          // Search Icon
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.search,
                color: Color(0xFF111827),
                size: 24,
              ),
              onPressed: () {
                // Handle search
              },
            ),
          ),
          // Filter Icon
          Container(
            width: 44,
            height: 44,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: () {
                // Handle filter action
              },
              icon: SvgPicture.asset(
                'assets/images/Bookings/Transport/Tuning.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF6B7280),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // White background container for tabs
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 12),
                // Transport Tab Bar
                const TransportTabBar(),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),

                  // Transport Cards based on selected tab
                  if (selectedTab == 'All' || selectedTab == 'Flights')
                    _buildFlightCards(flights),

                  // Placeholder for other transport types
                  if (selectedTab == 'Car')
                    _buildComingSoonSection('Car Rentals'),
                  if (selectedTab == 'Bus')
                    _buildComingSoonSection('Bus Services'),
                  if (selectedTab == 'Train')
                    _buildComingSoonSection('Train Bookings'),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build flight cards with buttons
  Widget _buildFlightCards(List<FlightCard> flights) {
    return Column(
      children:
          flights.map((flight) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF172554).withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Flight Card Content
                    Padding(
                      padding: const EdgeInsets.all(20),
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

                    // Buttons Section
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TransportButtonRow(
                        onViewDetails: () {
                          print('View details for ${flight.airlineName}');
                          // Navigate to details page or show bottom sheet
                        },
                        onBookNow: () {
                          print('Book now for ${flight.airlineName}');
                          // Navigate to booking page
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  // Coming soon section for other transport types
  Widget _buildComingSoonSection(String transportType) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEFF6FF),
              ),
              child: const Icon(
                Icons.directions_bus_outlined,
                size: 40,
                color: Color(0xFF3B82F6),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '$transportType Coming Soon',
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
                height: 1.33,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'We\'re working on bringing you the best $transportType options',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6B7280),
                height: 1.43,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
