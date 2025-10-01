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
  final String about;
  final String experience;
  final List<String> destinationSpecialties;
  final List<String> travelExpertise;
  final List<String> languages;

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
    required this.about,
    required this.experience,
    required this.destinationSpecialties,
    required this.travelExpertise,
    required this.languages,
  });
}
