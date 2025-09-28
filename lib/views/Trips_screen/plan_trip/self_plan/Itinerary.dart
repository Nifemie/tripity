import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/trip_reusable_buttons.dart';
import 'package:tripitify/providers/plan_trip_provider.dart';

// State Management
enum ViewMode { day, schedule }

class ItineraryState {
  final ViewMode viewMode;
  final String selectedDay;
  final int selectedDate;
  final List<String> activities;

  ItineraryState({
    required this.viewMode,
    required this.selectedDay,
    required this.selectedDate,
    required this.activities,
  });

  ItineraryState copyWith({
    ViewMode? viewMode,
    String? selectedDay,
    int? selectedDate,
    List<String>? activities,
  }) {
    return ItineraryState(
      viewMode: viewMode ?? this.viewMode,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedDate: selectedDate ?? this.selectedDate,
      activities: activities ?? this.activities,
    );
  }
}

class ItineraryNotifier extends StateNotifier<ItineraryState> {
  ItineraryNotifier()
      : super(ItineraryState(
    viewMode: ViewMode.day,
    selectedDay: 'Sun',
    selectedDate: 17,
    activities: List.generate(6, (index) => ''),
  ));

  void setViewMode(ViewMode mode) {
    state = state.copyWith(viewMode: mode);
  }

  void updateActivity(int index, String activity) {
    final updatedActivities = List<String>.from(state.activities);
    updatedActivities[index] = activity;
    state = state.copyWith(activities: updatedActivities);
  }
}

final itineraryProvider = StateNotifierProvider<ItineraryNotifier, ItineraryState>(
      (ref) => ItineraryNotifier(),
);


class ItineraryScreen extends ConsumerWidget {
  const ItineraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itineraryProvider);
    final currentStep = ref.watch(selfPlanStepProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            ref.read(selfPlanStepProvider.notifier).state--;
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Build Your Itinerary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '$currentStep/4',
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TripProgressBar(currentStep: currentStep),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Description
                    const Text(
                      'Map out your activities for each day.',
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Day/Schedule Toggle
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => ref.read(itineraryProvider.notifier).setViewMode(ViewMode.day),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: state.viewMode == ViewMode.day
                                      ? const Color(0xFFEFF6FF)
                                      : Colors.transparent,
                                  border: state.viewMode == ViewMode.day
                                      ? Border.all(color: const Color(0xFF3B82F6))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      size: 16,
                                      color: state.viewMode == ViewMode.day
                                          ? const Color(0xFF3B82F6)
                                          : const Color(0xFF6B7280),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Day',
                                      style: TextStyle(
                                        color: state.viewMode == ViewMode.day
                                            ? const Color(0xFF3B82F6)
                                            : const Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => ref.read(itineraryProvider.notifier).setViewMode(ViewMode.schedule),
                              child: Container(
                                height: 44,
                                decoration: BoxDecoration(
                                  color: state.viewMode == ViewMode.schedule
                                      ? const Color(0xFFEFF6FF)
                                      : Colors.transparent,
                                  border: state.viewMode == ViewMode.schedule
                                      ? Border.all(color: const Color(0xFF3B82F6))
                                      : null,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      size: 16,
                                      color: state.viewMode == ViewMode.schedule
                                          ? const Color(0xFF3B82F6)
                                          : const Color(0xFF6B7280),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Schedule',
                                      style: TextStyle(
                                        color: state.viewMode == ViewMode.schedule
                                            ? const Color(0xFF3B82F6)
                                            : const Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Day and Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.selectedDay,
                              style: const TextStyle(
                                color: Color(0xFF4B5563),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              child: Center(
                                child: Text(
                                  '${state.selectedDate}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Add activity logic here
                          },
                          child: Container(
                            height: 44,
                            padding: const EdgeInsets.only(left: 12, right: 16, top: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Color(0xFF3B82F6),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Add Activity',
                                  style: TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Time Slots
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final hour = index + 1;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Container(
                              height: 65,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9FAFB),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      '${hour}am',
                                      style: const TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: state.activities[index],
                                      onChanged: (value) {
                                        ref.read(itineraryProvider.notifier).updateActivity(index, value);
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Add your activity...',
                                        hintStyle: TextStyle(
                                          color: Color(0xFF9CA3AF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtons(
        onSaveForLater: () {
          ref.read(selfPlanStepProvider.notifier).state--;
          Navigator.of(context).pop();
        },
        onContinue: () {
          ref.read(selfPlanStepProvider.notifier).state++;
          context.push('/trip-summary');
        },
      ),
    );
  }
}
