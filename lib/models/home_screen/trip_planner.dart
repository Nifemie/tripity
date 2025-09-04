class TripPlanner {
  final String name;
  final double rating;
  final int reviews;
  final String location;
  final List<String> specialties;
  final int tripsPlanned;
  final String responseTime;
  final int price;
  final bool isVerified;
  final bool isAcceptingClients;
  final String? imagePath;

  const TripPlanner({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.location,
    required this.specialties,
    required this.tripsPlanned,
    required this.responseTime,
    required this.price,
    required this.isVerified,
    required this.isAcceptingClients,
    this.imagePath,
  });
}
