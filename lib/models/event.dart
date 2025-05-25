class Event {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime date;
  final String location;
  final String price;
  final int registeredCount;
  final String category;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.location,
    required this.price,
    required this.registeredCount,
    required this.category,
  });
} 