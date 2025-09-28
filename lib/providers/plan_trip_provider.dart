
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tripitify/models/plan_trip_model.dart';

// State provider for trip planning selection
final tripPlanningProvider = StateNotifierProvider<TripPlanningNotifier, TripPlanningState>((ref) {
  return TripPlanningNotifier();
});

class TripPlanningNotifier extends StateNotifier<TripPlanningState> {
  TripPlanningNotifier() : super(const TripPlanningState());

  void selectPlanningType(PlanningType type) {
    state = state.copyWith(selectedType: type);
  }
}

final selfPlanStepProvider = StateProvider<int>((ref) => 1);
