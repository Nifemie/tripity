import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/Bookings_widget/dashed_border_container.dart';

// ==================== ADD TO TRIP PAGE ====================

class AddToTripPage extends StatelessWidget {
  const AddToTripPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Scrollable Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Selected Experience Card
                  _buildSelectedExperienceCard(),
                  const SizedBox(height: 24),

                  // Create New Trip Card
                  _buildCreateNewTripCard(context),
                  const SizedBox(height: 24),

                  // Add to Existing Trip Section
                  _buildSectionTitle('Add to Existing Trip'),
                  const SizedBox(height: 12),

                  // Existing Trip Cards
                  _buildExistingTripCard(
                    'Tokyo Spring Adventure',
                    'Tokyo, Japan',
                    'Sep 17 - 19, 2025',
                    () {
                      _addToTrip(context, 'Tokyo Spring Adventure');
                    },
                  ),
                  const SizedBox(height: 12),

                  _buildExistingTripCard(
                    'European Getaway',
                    'Paris, France',
                    'Oct 2 - 7, 2025',
                    () {
                      _addToTrip(context, 'European Getaway');
                    },
                  ),
                  const SizedBox(height: 12),

                  _buildExistingTripCard(
                    'Summer in NYC',
                    'New York, USA',
                    'Nov 17 - 19, 2025',
                    () {
                      _addToTrip(context, 'Summer in NYC');
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==================== HEADER ====================

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Close Button
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SvgPicture.asset(
              'assets/images/Trips/Close_Circle.svg',
              width: 32,
              height: 32,
            ),
          ),
          const SizedBox(width: 16),

          // Title
          const Text(
            'Add to Trip',
            style: TextStyle(
              fontFamily: 'Instrument Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF111827),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ==================== SELECTED EXPERIENCE CARD ====================

  Widget _buildSelectedExperienceCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFEFF6FF),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF172554).withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          // Thumbnail Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/Bookings/experience/paris_walking.png',
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Experience Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Paris Walking Tour: Montmartre & Artists',
                  style: TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Paris, France',
                      style: TextStyle(
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
          ),
        ],
      ),
    );
  }

  // ==================== CREATE NEW TRIP CARD ====================

  Widget _buildCreateNewTripCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _createNewTrip(context);
      },
      child: DashedBorderContainer(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFD1D5DB),
        strokeWidth: 2,
        dashPattern: const [5.0, 5.0],
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Plus Icon in Blue Circle
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFEFF6FF),
                ),
                child: const Icon(Icons.add, size: 20, color: Color(0xFF3B82F6)),
              ),
              const SizedBox(width: 16),

              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create New Trip',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Start planning a new trip with this experience',
                      style: TextStyle(
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

              // Arrow Icon
              const Icon(Icons.chevron_right, size: 20, color: Color(0xFF6B7280)),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== SECTION TITLE ====================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: 'Instrument Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
        height: 1.4,
      ),
    );
  }

  // ==================== EXISTING TRIP CARD ====================

  Widget _buildExistingTripCard(
    String tripName,
    String location,
    String dates,
    VoidCallback onAdd,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFF3F4F6),
      ),
      child: Row(
        children: [
          // Trip Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Name
                Text(
                  tripName,
                  style: const TextStyle(
                    fontFamily: 'Instrument Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      location,
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
                const SizedBox(height: 4),

                // Dates
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF6B7280),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      dates,
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
          ),

          // Add Button
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, size: 20, color: Color(0xFF111827)),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== ACTION METHODS ====================

  void _createNewTrip(BuildContext context) {
    // Show success feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Creating new trip...'),
        duration: Duration(seconds: 1),
      ),
    );

    // Navigate to trip creation flow
    Future.delayed(const Duration(milliseconds: 500), () {
      context.push('/self-plan-setup?fromBooking=true');
    });
  }

  void _addToTrip(BuildContext context, String tripName) {
    // Navigate to confirmation page
    Navigator.of(context).pop(); // Close the add to trip modal first

    // Then navigate to confirmation
    context.push(
      '/trip-confirmation',
      extra: {
        'tripName': tripName,
        'experienceName': 'Paris Walking Tour: Montmartre & Artists',
      },
    );
  }
}
