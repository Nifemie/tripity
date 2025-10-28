import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/Bookings_widget/Events_tab.dart';
import 'package:tripitify/widgets/Bookings_widget/event_card_widget.dart';
import 'package:tripitify/widgets/Bookings_widget/custom_reusable_button.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:ui';

class EventsPage extends ConsumerWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(eventsProvider);
    final favoriteEvents = ref.watch(favoriteEventsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
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
          'Events',
          style: TextStyle(
            fontFamily: 'Instrument Sans',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF111827),
            height: 1.4,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // Handle search
            },
            child: Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.search,
                color: Color(0xFF111827),
                size: 20,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle filter
            },
            child: Container(
              height: 44,
              width: 44,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
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
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Tabs
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: EventsTabBar(),
          ),
          const SizedBox(height: 24),
          // Event Cards
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    _buildEventCards(context, ref, events, favoriteEvents),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCards(
    BuildContext context,
    WidgetRef ref,
    List<EventCard> events,
    Set<String> favoriteEvents,
  ) {
    print('Building ${events.length} event cards'); // Debug print

    return Column(
      children:
          events.map((event) {
            final isFavorite = favoriteEvents.contains(event.id);

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Image with Overlay (full width with top rounded corners)
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Stack(
                          children: [
                            // Event Image - Full Width
                            Positioned.fill(
                              child: Image.asset(
                                event.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Heart Icon Overlay
                            Positioned(
                              top: 12,
                              right: 12,
                              child: GestureDetector(
                                onTap: () {
                                  final favorites = ref.read(
                                    favoriteEventsProvider.notifier,
                                  );
                                  if (isFavorite) {
                                    favorites.state = {...favoriteEvents}
                                      ..remove(event.id);
                                  } else {
                                    favorites.state = {
                                      ...favoriteEvents,
                                      event.id,
                                    };
                                  }
                                },
                                child: ClipOval(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0x3D000000),
                                      ),
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        size: 20,
                                        color:
                                            isFavorite
                                                ? const Color(0xFFEF4444)
                                                : const Color(0xFF9CA3AF),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Event Info Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: EventInfoSection(
                        title: event.title,
                        description: event.description,
                        location: event.location,
                        time: event.time,
                        category: event.category,
                        rating: event.rating,
                        reviewCount: event.reviewCount,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Price Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: EventPriceSection(
                        pricePerTicket: event.pricePerTicket,
                        additionalInfo: event.additionalInfo,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Buttons Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: 'Event Details',
                              onPressed: () {
                                print('View details for ${event.title}');
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: PrimaryButton(
                              text: 'Buy Tickets',
                              onPressed: () {
                                print('Buy tickets for ${event.title}');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
