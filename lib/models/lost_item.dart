class LostItem {
  final String id;
  final String name;
  final String location;
  final String timeAgo;
  final String type; // lost, found
  final String? imageUrl;
  final String description;

  LostItem({
    required this.id,
    required this.name,
    required this.location,
    required this.timeAgo,
    required this.type,
    this.imageUrl,
    required this.description,
  });
}
