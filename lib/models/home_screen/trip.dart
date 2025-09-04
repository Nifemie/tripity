class Trip {
  final String destination;
  final String country;
  final DateTime startDate;
  final DateTime endDate;
  final int daysUntilStart;

  const Trip({
    required this.destination,
    required this.country,
    required this.startDate,
    required this.endDate,
    required this.daysUntilStart,
  });
}
