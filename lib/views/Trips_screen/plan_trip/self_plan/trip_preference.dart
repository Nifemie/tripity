import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State classes
class TravelStyle {
  final String name;
  final String description;

  TravelStyle({required this.name, required this.description});
}

class AccommodationType {
  final String name;
  final String description;
  final IconData icon;

  AccommodationType({
    required this.name,
    required this.description,
    required this.icon,
  });
}

class TransportationMode {
  final String name;
  final IconData icon;

  TransportationMode({required this.name, required this.icon});
}

class TripPreferencesState {
  final String selectedTravelStyle;
  final double tripBudget;
  final String budgetInputText;
  final String selectedAccommodation;
  final List<String> selectedTransportation;
  final String personalNote;

  TripPreferencesState({
    this.selectedTravelStyle = '',
    this.tripBudget = 500.0,
    this.budgetInputText = '',
    this.selectedAccommodation = '',
    this.selectedTransportation = const [],
    this.personalNote = '',
  });

  TripPreferencesState copyWith({
    String? selectedTravelStyle,
    double? tripBudget,
    String? budgetInputText,
    String? selectedAccommodation,
    List<String>? selectedTransportation,
    String? personalNote,
  }) {
    return TripPreferencesState(
      selectedTravelStyle: selectedTravelStyle ?? this.selectedTravelStyle,
      tripBudget: tripBudget ?? this.tripBudget,
      budgetInputText: budgetInputText ?? this.budgetInputText,
      selectedAccommodation: selectedAccommodation ?? this.selectedAccommodation,
      selectedTransportation: selectedTransportation ?? this.selectedTransportation,
      personalNote: personalNote ?? this.personalNote,
    );
  }
}

// StateNotifier
class TripPreferencesNotifier extends StateNotifier<TripPreferencesState> {
  TripPreferencesNotifier() : super(TripPreferencesState());

  void setTravelStyle(String style) {
    state = state.copyWith(selectedTravelStyle: style);
  }

  void setBudget(double budget) {
    state = state.copyWith(tripBudget: budget);
  }

  void setBudgetInputText(String text) {
    state = state.copyWith(budgetInputText: text);
  }

  void setAccommodation(String accommodation) {
    state = state.copyWith(selectedAccommodation: accommodation);
  }

  void toggleTransportation(String transportation) {
    final List<String> newList = List.from(state.selectedTransportation);
    if (newList.contains(transportation)) {
      newList.remove(transportation);
    } else {
      newList.add(transportation);
    }
    state = state.copyWith(selectedTransportation: newList);
  }

  void setPersonalNote(String note) {
    state = state.copyWith(personalNote: note);
  }
}

// Provider
final tripPreferencesProvider = StateNotifierProvider<TripPreferencesNotifier, TripPreferencesState>(
      (ref) => TripPreferencesNotifier(),
);

class TripPreferencesScreen extends ConsumerWidget {
  const TripPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tripPreferencesProvider);
    final notifier = ref.read(tripPreferencesProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Trip Preferences',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Instrument Sans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text(
              '2/4',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            const Text(
              'Set your budget, including all expenses and preferences',
              style: TextStyle(
                color: Color(0xFF4B5563),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Travel Style Section
            _buildTravelStyleSection(state, notifier, context),
            const SizedBox(height: 32),

            // Trip Budget Section
            _buildTripBudgetSection(state, notifier, context),
            const SizedBox(height: 32),

            // Accommodation Preference Section
            _buildAccommodationSection(state, notifier, context),
            const SizedBox(height: 32),

            // Transportation Mode Section
            _buildTransportationSection(state, notifier),
            const SizedBox(height: 32),

            // Personal Note Section
            _buildPersonalNoteSection(state, notifier),
          ],
        ),
      ),
    );
  }

  Widget _buildTravelStyleSection(TripPreferencesState state, TripPreferencesNotifier notifier, BuildContext context) {
    final travelStyles = [
      TravelStyle(name: 'Budget-Friendly', description: 'Great value for money'),
      TravelStyle(name: 'Comfortable', description: 'Balance of comfort and value'),
      TravelStyle(name: 'Luxury', description: 'Premium experiences'),
      TravelStyle(name: 'Adventure', description: 'Active and exciting'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What\'s your travel style?',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: travelStyles.map((style) {
            final isSelected = state.selectedTravelStyle == style.name;
            return GestureDetector(
              onTap: () => notifier.setTravelStyle(style.name),
              child: Container(
                width: (MediaQuery.of(context).size.width - 56) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.1) : const Color(0xFFF3F4F6),
                  border: isSelected ? Border.all(color: const Color(0xFF3B82F6)) : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      style.name,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      style.description,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTripBudgetSection(TripPreferencesState state, TripPreferencesNotifier notifier, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trip Budget',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),

        // Budget Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '\$0',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '\$500',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '\$10,000+',
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Slider
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
            activeTrackColor: const Color(0xFF3B82F6),
            inactiveTrackColor: const Color(0xFFF3F4F6),
            thumbColor: const Color(0xFF3B82F6),
          ),
          child: Slider(
            value: state.tripBudget,
            min: 0,
            max: 10000,
            onChanged: (value) => notifier.setBudget(value),
          ),
        ),
        const SizedBox(height: 16),

        // Budget Input
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD1D5DB)),
            color: const Color(0xFFF9FAFB),
          ),
          child: Center(
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter Amount',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintStyle: TextStyle(
                  color: Color(0xFF6B7280),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onChanged: (value) => notifier.setBudgetInputText(value),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Budget Includes Info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFEFF6FF),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF3B82F6),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Budget includes:',
                    style: TextStyle(
                      color: Color(0xFF111827),
                      fontFamily: 'Instrument Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Accommodation, transportation, meals, activities, and miscellaneous expenses',
                style: TextStyle(
                  color: Color(0xFF4B5563),
                  fontFamily: 'Instrument Sans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccommodationSection(TripPreferencesState state, TripPreferencesNotifier notifier, BuildContext context) {
    final accommodationTypes = [
      AccommodationType(name: 'Hotel', description: 'Traditional hotel stay', icon: Icons.hotel),
      AccommodationType(name: 'Apartment', description: 'Private apartment rental', icon: Icons.apartment),
      AccommodationType(name: 'Hostel', description: 'Budget-friendly room', icon: Icons.bed),
      AccommodationType(name: 'Luxury Resort', description: 'Premium resort experience', icon: Icons.star),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accommodation Preference',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Choose your preferred type of stay',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: accommodationTypes.map((accommodation) {
            final isSelected = state.selectedAccommodation == accommodation.name;
            return GestureDetector(
              onTap: () => notifier.setAccommodation(accommodation.name),
              child: Container(
                width: (MediaQuery.of(context).size.width - 56) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.1) : const Color(0xFFF3F4F6),
                  border: isSelected ? Border.all(color: const Color(0xFF3B82F6)) : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      accommodation.icon,
                      size: 32,
                      color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      accommodation.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      accommodation.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontFamily: 'Instrument Sans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTransportationSection(TripPreferencesState state, TripPreferencesNotifier notifier) {
    final transportationModes = [
      TransportationMode(name: 'Flight', icon: Icons.flight),
      TransportationMode(name: 'Car', icon: Icons.directions_car),
      TransportationMode(name: 'Train', icon: Icons.train),
      TransportationMode(name: 'Bus', icon: Icons.directions_bus),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transportation Mode',
          style: TextStyle(
            color: Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'How would you like to travel?',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontFamily: 'Instrument Sans',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: transportationModes.map((transport) {
            final isSelected = state.selectedTransportation.contains(transport.name);
            return GestureDetector(
              onTap: () => notifier.toggleTransportation(transport.name),
              child: Container(
                width: 85,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected ? const Color(0xFF3B82F6).withOpacity(0.1) : const Color(0xFFF3F4F6),
                  border: isSelected ? Border.all(color: const Color(0xFF3B82F6)) : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      transport.icon,
                      size: 24,
                      color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      transport.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF111827),
                        fontFamily: 'Instrument Sans',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPersonalNoteSection(TripPreferencesState state, TripPreferencesNotifier notifier) {
    return Container(
      width: 390,
      height: 44,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_note,
                color: Color(0xFF6B7280),
                size: 20,
              ),
              const SizedBox(width: 12),
              const Text(
                'Leave a personal note for yourself',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontFamily: 'Instrument Sans',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                ),
              ),
            ],
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF6B7280),
            size: 16,
          ),
        ],
      ),
    );
  }
}