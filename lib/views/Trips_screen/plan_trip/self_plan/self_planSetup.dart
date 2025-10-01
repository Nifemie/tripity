import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tripitify/widgets/SelfTrip_plans_widgets/travel_type_card.dart';
import 'package:tripitify/widgets/SelfTrip_plans_widgets/interest_chip.dart';
import 'package:tripitify/widgets/SelfTrip_plans_widgets/date_field.dart';
import 'package:tripitify/widgets/SelfTrip_plans_widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tripitify/widgets/trip_reusable_buttons.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/providers/plan_trip_provider.dart';


// State models
class TripBasicDetailsState {
  final String tripTitle;
  final String destination;
  final DateTime? startDate;
  final DateTime? endDate;
  final String selectedTravelType;
  final List<String> selectedInterests;

  const TripBasicDetailsState({
    this.tripTitle = '',
    this.destination = '',
    this.startDate,
    this.endDate,
    this.selectedTravelType = 'Solo',
    this.selectedInterests = const [],
  });

  TripBasicDetailsState copyWith({
    String? tripTitle,
    String? destination,
    DateTime? startDate,
    DateTime? endDate,
    String? selectedTravelType,
    List<String>? selectedInterests,
  }) {
    return TripBasicDetailsState(
      tripTitle: tripTitle ?? this.tripTitle,
      destination: destination ?? this.destination,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      selectedTravelType: selectedTravelType ?? this.selectedTravelType,
      selectedInterests: selectedInterests ?? this.selectedInterests,
    );
  }

  int get tripDuration {
    if (startDate == null || endDate == null) return 3;
    return endDate!.difference(startDate!).inDays + 1;
  }
}

// Riverpod provider
final tripBasicDetailsProvider = StateNotifierProvider<TripBasicDetailsNotifier, TripBasicDetailsState>((ref) {
  return TripBasicDetailsNotifier();
});

class TripBasicDetailsNotifier extends StateNotifier<TripBasicDetailsState> {
  TripBasicDetailsNotifier() : super(const TripBasicDetailsState());

  void updateTripTitle(String title) {
    state = state.copyWith(tripTitle: title);
  }

  void updateDestination(String destination) {
    state = state.copyWith(destination: destination);
  }

  void updateStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
  }

  void updateEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
  }

  void updateTravelType(String type) {
    state = state.copyWith(selectedTravelType: type);
  }

  void toggleInterest(String interest) {
    final currentInterests = List<String>.from(state.selectedInterests);
    if (currentInterests.contains(interest)) {
      currentInterests.remove(interest);
    } else {
      currentInterests.add(interest);
    }
    state = state.copyWith(selectedInterests: currentInterests);
  }

  
}

// Main page widget
class TripBasicDetailsPage extends ConsumerWidget {
  const TripBasicDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tripBasicDetailsProvider);
    final notifier = ref.read(tripBasicDetailsProvider.notifier);
    final currentStep = ref.watch(selfPlanStepProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, currentStep),
      body: Column(
        children: [
          TripProgressBar(currentStep: currentStep),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Let's start with the basics"),
                  const SizedBox(height: 24),
                  _buildTripTitleField(state.tripTitle, notifier.updateTripTitle),
                  const SizedBox(height: 20),
                  _buildDestinationField(state.destination, notifier.updateDestination),
                  const SizedBox(height: 24),
                  _buildDateFields(state, notifier),
                  const SizedBox(height: 24),
                  _buildTripDuration(state.tripDuration),
                  const SizedBox(height: 32),
                  _buildTravelTypeSection(state.selectedTravelType, notifier.updateTravelType),
                  const SizedBox(height: 32),
                  _buildInterestsSection(state.selectedInterests, notifier.toggleInterest),
                  
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtons(
        onSaveForLater: () {},
        onContinue: () {
          ref.read(selfPlanStepProvider.notifier).state++;
          context.push('/trip-preference');
        },
      ),
    );
  }

  

  PreferredSizeWidget _buildAppBar(BuildContext context, int currentStep) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF111827)),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Basic Details',
        style: TextStyle(
          color: const Color(0xFF111827),
          fontFamily: 'Instrument Sans',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.375,
        ),
      ),
      centerTitle: false, // Changed from true to false
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: Text(
              '$currentStep/4',
              style: TextStyle(
                color: const Color(0xFF6B7280),
                fontFamily: 'Instrument Sans',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
  

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF4B5563),
        fontFamily: 'Instrument Sans',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
    );
  }

  Widget _buildTripTitleField(String value, Function(String) onChanged) {
    return CustomTextField(
      label: RichText(
        text: TextSpan(
          style: TextStyle(
            color: const Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          children: [
            TextSpan(text: 'Trip Title'),
            TextSpan(
              text: ' (optional)',
              style: TextStyle(
                color: const Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
      hintText: 'e.g Weekend in Paris',
      onChanged: onChanged,
    );
  }

  Widget _buildDestinationField(String value, Function(String) onChanged) {
    return CustomTextField(
      label: Text(
        'Destination',
        style: TextStyle(
          color: const Color(0xFF111827),
          fontFamily: 'Instrument Sans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.5,
        ),
      ),
      hintText: 'Select or Search destination',
      onChanged: onChanged,
      leadingIcon: SvgPicture.asset(
        'assets/images/Trips/Map_icon.svg',
        width: 20,
        height: 20,
      ),
      trailingIcon: Icons.keyboard_arrow_down,
    );
  }

  Widget _buildDateFields(TripBasicDetailsState state, TripBasicDetailsNotifier notifier) {
    return Row(
      children: [
        Expanded(
          child: DateField(
            label: 'Start Date',
            date: state.startDate,
            placeholder: 'Aug 17, 2025',
            onTap: () => _selectDate(notifier.updateStartDate),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: DateField(
            label: 'End Date',
            date: state.endDate,
            placeholder: 'Aug 19, 2025',
            onTap: () => _selectDate(notifier.updateEndDate),
          ),
        ),
      ],
    );
  }

  Widget _buildTripDuration(int duration) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF0F9FF),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Trip Duration:',
            style: TextStyle(
              color: const Color(0xFF1E40AF),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
          Text(
            '$duration days',
            style: TextStyle(
              color: const Color(0xFF1E40AF),
              fontFamily: 'Instrument Sans',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelTypeSection(String selectedType, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Who's traveling?",
          style: TextStyle(
            color: const Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: TravelTypeCard(
              type: 'Solo',
              subtitle: 'Just me',
              icon: SvgPicture.asset('assets/images/account_setup/User.svg', width: 24, height: 24),
              isSelected: selectedType == 'Solo',
              onTap: () => onChanged('Solo'),
            )),
            const SizedBox(width: 12),
            Expanded(child: TravelTypeCard(
              type: 'Couple',
              subtitle: 'Me + 1',
              icon: SvgPicture.asset('assets/images/Trips/Hearts.svg', width: 24, height: 24),
              isSelected: selectedType == 'Couple',
              onTap: () => onChanged('Couple'),
            )),
            const SizedBox(width: 12),
            Expanded(child: TravelTypeCard(
              type: 'Family',
              subtitle: 'Family trip',
              icon: SvgPicture.asset('assets/images/account_setup/Users.svg', width: 24, height: 24),
              isSelected: selectedType == 'Family',
              onTap: () => onChanged('Family'),
            )),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TravelTypeCard(
              type: 'Group',
              subtitle: 'Group of friends',
              icon: SvgPicture.asset('assets/images/account_setup/Users.svg', width: 24, height: 24),
              isSelected: selectedType == 'Group',
              onTap: () => onChanged('Group'),
            )),
            const SizedBox(width: 12),
            Expanded(child: TravelTypeCard(
              type: 'Business',
              subtitle: 'Work travel',
              icon: SvgPicture.asset('assets/images/account_setup/Camera.svg', width: 24, height: 24),
              isSelected: selectedType == 'Business',
              onTap: () => onChanged('Business'),
            )),
            const SizedBox(width: 12),
            Expanded(child: Container()), // Empty space to maintain layout
          ],
        ),
      ],
    );
  }

  Widget _buildInterestsSection(List<String> selectedInterests, Function(String) onToggle) {
    const interests = ['Nature', 'Photography', 'Hiking', 'Food & Dining'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Interests/Hobbies',
          style: TextStyle(
            color: const Color(0xFF111827),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose what you are interested',
          style: TextStyle(
            color: const Color(0xFF6B7280),
            fontFamily: 'Instrument Sans',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...interests.map((interest) => InterestChip(
              interest: interest,
              isSelected: selectedInterests.contains(interest),
              onTap: () => onToggle(interest),
            )),
            _buildAddInterestChip(),
          ],
        ),
      ],
    );
  }

  Widget _buildAddInterestChip() {
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9999), // Full border radius to match the pills
        color: const Color(0xFF1F2937), // Dark background (Neutral Gray 800)
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white, // White plus icon
        size: 20,
      ),
    );
  }

  
  

  void _selectDate(Function(DateTime) onDateSelected) {
    // Implement date picker logic here
    // For now, just selecting a default date
    onDateSelected(DateTime.now());
  }
}