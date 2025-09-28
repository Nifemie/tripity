import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/widgets/trip_progress_bar.dart';
import 'package:tripitify/widgets/trip_reusable_buttons.dart';
import 'package:tripitify/providers/plan_trip_provider.dart';
import 'package:go_router/go_router.dart';

// State Management
class TripSummaryState {
  final String tripTitle;
  final String location;
  final String date;
  final String duration;
  final String tripType;
  final List<String> interests;
  final List<ItineraryDay> itineraryDays;
  final String budget;
  final String accommodation;
  final String transportation;
  final String personalNote;

  TripSummaryState({
    required this.tripTitle,
    required this.location,
    required this.date,
    required this.duration,
    required this.tripType,
    required this.interests,
    required this.itineraryDays,
    required this.budget,
    required this.accommodation,
    required this.transportation,
    required this.personalNote,
  });
}

class ItineraryDay {
  final int day;
  final String date;
  final List<Activity> activities;

  ItineraryDay({
    required this.day,
    required this.date,
    required this.activities,
  });
}

class Activity {
  final String title;
  final String location;
  final String timeRange;
  final String duration;
  final String type;

  Activity({
    required this.title,
    required this.location,
    required this.timeRange,
    required this.duration,
    required this.type,
  });
}

// Sample data provider
final tripSummaryProvider = Provider<TripSummaryState>((ref) {
  return TripSummaryState(
    tripTitle: "Weekend in Paris",
    location: "Paris, France",
    date: "Aug 17 - 19, 2025",
    duration: "3 days",
    tripType: "Solo",
    interests: ["Nature", "Photography", "Food & Dining", "Hiking"],
    itineraryDays: [
      ItineraryDay(
        day: 1,
        date: "Sun, 17 Aug",
        activities: [
          Activity(
            title: "Visit a tourist attraction",
            location: "Eiffel Tower, Av. Gustave Eiffel, 75007 Paris, France",
            timeRange: "3:00 pm - 4:00 pm",
            duration: "Duration: 1 hour",
            type: "CUSTOM ACTIVITY",
          ),
          Activity(
            title: "Lunch at hotel",
            location: "Paris France",
            timeRange: "5:00 pm - 5:30 pm",
            duration: "Duration: 30 minutes",
            type: "CUSTOM ACTIVITY",
          ),
        ],
      ),
      ItineraryDay(
        day: 2,
        date: "Day 2",
        activities: [],
      ),
    ],
    budget: "\$1500",
    accommodation: "Hotel",
    transportation: "Car",
    personalNote: "First time visiting Paris, make sure to explore traditional and modern culture mix",
  );
});

class TripSummaryScreen extends ConsumerWidget {
  const TripSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tripData = ref.watch(tripSummaryProvider);
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
          'Trip Summary',
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
          const SizedBox(height: 32),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  const Text(
                    "Here's how your trip is shaping up",
                    style: TextStyle(
                      color: Color(0xFF4B5563),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Trip Title
                  Text(
                    tripData.tripTitle,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Trip Details Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
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
                      children: [
                        _buildDetailRow(Icons.location_on_outlined, "Location", tripData.location),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.calendar_today_outlined, "Date", tripData.date),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.schedule, "Duration", tripData.duration),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.person_outline, "Trip Type", tripData.tripType),

                        // Divider line
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFFF3F4F6),
                        ),
                        const SizedBox(height: 16),

                        // Your Interests
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            "Your Interests",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: tripData.interests.map((interest) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF3F4F6),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  interest,
                                  style: const TextStyle(
                                    color: Color(0xFF374151),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Itinerary Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
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
                        // Your Itinerary Title inside container
                        const Text(
                          "Your Itinerary",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Scrollable itinerary content
                        SizedBox(
                          height: 300, // Fixed height to make it scrollable
                          child: SingleChildScrollView(
                            child: Stack(
                              children: [
                                // Timeline line
                                Positioned(
                                  left: 4,
                                  top: 8,
                                  bottom: 0,
                                  child: Container(
                                    width: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: const Color(0xFFEFF6FF),
                                    ),
                                  ),
                                ),
                                // Itinerary days
                                Column(
                                  children: tripData.itineraryDays.map((day) => _buildItineraryDay(day)).toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Preferences & Budget Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
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
                        const Text(
                          "Preferences & Budget",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.attach_money, "Budget", tripData.budget),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.hotel_outlined, "Accommodation", tripData.accommodation),
                        const SizedBox(height: 16),
                        _buildDetailRow(Icons.directions_car_outlined, "Transportation", tripData.transportation),

                        // Divider line
                        const SizedBox(height: 16),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: const Color(0xFFF3F4F6),
                        ),
                        const SizedBox(height: 16),

                        // Personal Note
                        const Text(
                          "Personal Note",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tripData.personalNote,
                          style: const TextStyle(
                            color: Color(0xFF4B5563),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtons(
        onSaveForLater: () {
          // Edit trip logic
        },
        onContinue: () {
          context.push('/trip-ready');
        },
        saveText: 'Edit Trip',
        continueText: 'Finalize Trip Plan',
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF6B7280),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItineraryDay(ItineraryDay day) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF3B82F6),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Day ${day.day}",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            day.date,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Activities
        ...day.activities.map((activity) => Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 16),
          child: _buildActivity(activity),
        )),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildActivity(Activity activity) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFFF9FAFB),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
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
              Expanded(
                child: Text(
                  activity.location,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(
                Icons.schedule,
                size: 14,
                color: Color(0xFF6B7280),
              ),
              const SizedBox(width: 4),
              Text(
                "${activity.timeRange} - ${activity.duration}",
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            activity.type,
            style: const TextStyle(
              color: Color(0xFF3B82F6),
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}