class Destination {
  final String name;
  final String description;
  final String rating;
  final String country;
  final String duration;
  final String price;
  final List<String> tags;
  final String temperature;
  final bool hasImage;
  final String? imagePath;
  final int? travellersCount;

  const Destination({
    required this.name,
    required this.description,
    required this.rating,
    required this.country,
    required this.duration,
    required this.price,
    required this.tags,
    required this.temperature,
    required this.hasImage,
    this.imagePath,
    this.travellersCount,
  });
}
