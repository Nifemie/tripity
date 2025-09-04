class UpcomingTrip {
  final String title;
  final String status;
  final String location;
  final String dates;
  final String type;
  final String price;
  final String planner;
  final String? imagePath;

  const UpcomingTrip({
    required this.title,
    required this.status,
    required this.location,
    required this.dates,
    required this.type,
    required this.price,
    required this.planner,
    this.imagePath,
  });
}
