import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:ui';
import 'overview.dart';
import '../../../../widgets/Explore_widgets/actions_button.dart';
import 'highlights.dart';
import 'events.dart';
import 'experience.dart';

// State provider for selected tab
final selectedTabProvider = StateProvider<int>((ref) => 0);

class DestinationDetailScreen extends ConsumerWidget {
  final String imagePath;
  final String destinationName;
  final String country;
  final String description;
  final double rating;
  final String aboutTitle;
  final String aboutDescription;

  const DestinationDetailScreen({
    Key? key,
    required this.imagePath,
    required this.destinationName,
    required this.country,
    required this.description,
    required this.rating,
    required this.aboutTitle,
    required this.aboutDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background image with blur effect at bottom
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // App bar with back button and favorite icon
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black.withOpacity(0.24),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.24),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Favorite button
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.black.withOpacity(0.24),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 11, sigmaY: 11),
                        child: Container(
                          padding: const EdgeInsets.all(8.8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.24),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.5 + 20,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$destinationName, $country',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'InstrumentSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                        letterSpacing: 0,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'InstrumentSans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'InstrumentSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Bottom content
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.5),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        _buildTabItem('Overview', 0, selectedTab, ref),
                        const SizedBox(width: 24),
                        _buildTabItem('Highlights', 1, selectedTab, ref),
                        const SizedBox(width: 24),
                        _buildTabItem('Events', 2, selectedTab, ref),
                        const SizedBox(width: 24),
                        _buildTabItem('Experience', 3, selectedTab, ref),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (selectedTab == 0)
                          _buildOverviewContent()
                        else if (selectedTab == 1)
                          const TopHighlightsWidget()
                        else if (selectedTab == 2)
                          const EventsWidget()
                        else if (selectedTab == 3)
                          const ExperienceWidget()
                        else
                          const SizedBox(height: 200), // Placeholder for other tabs
                      ],
                    ),
                  ),
                ),
              ),
              ActionButtonsWidget(
                onPlanTripPressed: () {
                  print('Plan a Trip Here pressed');
                  // Handle plan trip action
                },
                onBrowseOptionsPressed: () {
                  print('Browse Travel Options pressed');
                  // Handle browse options action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index, int selectedTab, WidgetRef ref) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () {
        ref.read(selectedTabProvider.notifier).state = index;
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF111827) : const Color(0xFF6B7280),
              fontFamily: 'InstrumentSans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              height: 1.25,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: title.length * 8.0, // Approximate width based on text
            color: isSelected ? const Color(0xFF111827) : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewContent() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF3F4F6)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                aboutTitle,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'InstrumentSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                aboutDescription,
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontFamily: 'InstrumentSans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const OverviewScreen(),
      ],
    );
  }
}








