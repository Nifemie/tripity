class LocationState {
  final String location;
  final bool isLoading;
  final String? error;

  const LocationState({
    required this.location,
    required this.isLoading,
    this.error,
  });

  LocationState copyWith({
    String? location,
    bool? isLoading,
    String? error,
  }) {
    return LocationState(
      location: location ?? this.location,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
