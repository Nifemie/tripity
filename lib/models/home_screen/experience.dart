class Experience {
  final String imagePath;
  final String title;
  final double rating;
  final String description;
  final String location;
  final int reviewCount;
  final String distance;
  final List<String> tags;
  final int price;

  const Experience({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.description,
    required this.location,
    required this.reviewCount,
    required this.distance,
    required this.tags,
    required this.price,
  });
}
