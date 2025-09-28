import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State Management
class DestinationSelectionState {
  final String searchQuery;
  final List<String> trendingDestinations;
  final String? selectedDestination;

  DestinationSelectionState({
    required this.searchQuery,
    required this.trendingDestinations,
    this.selectedDestination,
  });

  DestinationSelectionState copyWith({
    String? searchQuery,
    List<String>? trendingDestinations,
    String? selectedDestination,
  }) {
    return DestinationSelectionState(
      searchQuery: searchQuery ?? this.searchQuery,
      trendingDestinations: trendingDestinations ?? this.trendingDestinations,
      selectedDestination: selectedDestination ?? this.selectedDestination,
    );
  }
}

class DestinationNotifier extends StateNotifier<DestinationSelectionState> {
  DestinationNotifier()
      : super(DestinationSelectionState(
    searchQuery: '',
    trendingDestinations: [
      'Paris, France',
      'London, UK',
      'Cleveland, USA',
      'Ontario, Canada',
      'Bali, Indonesia',
      'Cape Town, South Africa',
      'San Francisco, USA',
      'Manchester, UK',
      'Liverpool, UK',
      'Kyoto, Japan',
    ],
  ));

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void selectDestination(String destination) {
    state = state.copyWith(selectedDestination: destination);
  }

  void clearSelection() {
    state = state.copyWith(selectedDestination: null);
  }
}

final destinationProvider = StateNotifierProvider<DestinationNotifier, DestinationSelectionState>(
      (ref) => DestinationNotifier(),
);

class DestinationSelectionScreen extends ConsumerWidget {
  const DestinationSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(destinationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // This prevents render overflow
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),

                    // Title - Centered
                    const Text(
                      'Where are you planning to travel to?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.375, // 27.5px / 20px = 1.375
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle - Centered with line break
                    const Text(
                      'Choose your destination so we can match you with planners\nwho know it best.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5, // 21px / 14px = 1.5
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Search Bar
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: state.searchQuery.isNotEmpty
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFFE5E7EB),
                        ),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          ref.read(destinationProvider.notifier).updateSearchQuery(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search destination',
                          hintStyle: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF9CA3AF),
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Trending Destinations - Left aligned
                    Container(
                      width: double.infinity,
                      child: const Text(
                        'Trending Destinations',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 1.5, // 21px / 14px = 1.5
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Destination Grid
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: state.trendingDestinations.map((destination) {
                        final isSelected = state.selectedDestination == destination;
                        return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              ref.read(destinationProvider.notifier).clearSelection();
                            } else {
                              ref.read(destinationProvider.notifier).selectDestination(destination);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFEFF6FF)
                                  : const Color(0xFFF9FAFB),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF3B82F6)
                                    : const Color(0xFFE5E7EB),
                              ),
                            ),
                            child: Text(
                              destination,
                              style: TextStyle(
                                color: isSelected
                                    ? const Color(0xFF3B82F6)
                                    : const Color(0xFF374151),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // Bottom Button - Fixed at bottom
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  gradient: state.selectedDestination != null
                      ? const LinearGradient(
                    begin: Alignment(-0.04, -1.0),
                    end: Alignment(1.07, 1.0),
                    colors: [
                      Color(0xFF3B82F6),
                      Color(0xFF2563EB),
                      Color(0xFF1E40AF),
                    ],
                    stops: [0.0, 0.51, 1.0],
                  )
                      : null,
                  color: state.selectedDestination == null
                      ? const Color(0xFFE5E7EB)
                      : null,
                ),
                child: ElevatedButton(
                  onPressed: state.selectedDestination != null
                      ? () {
                    // Find planners logic
                    print('Finding planners for: ${state.selectedDestination}');
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: Text(
                    'Find Planners for This Destination',
                    style: TextStyle(
                      color: state.selectedDestination != null
                          ? Colors.white
                          : const Color(0xFF9CA3AF),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}