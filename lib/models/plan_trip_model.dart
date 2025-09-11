enum PlanningType { planItMyself, useTripPlanner }

class TripPlanningState {
  final PlanningType? selectedType;

  const TripPlanningState({this.selectedType});

  TripPlanningState copyWith({PlanningType? selectedType}) {
    return TripPlanningState(selectedType: selectedType);
  }
}
