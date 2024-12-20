class Tour {
  final String id;
  final String city;
  final String attractions;
  final String days;
  final Map<String, String> prices;
  final List<String> images;

  Tour({
    required this.id,
    required this.city,
    required this.attractions,
    required this.days,
    required this.prices,
    required this.images,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['_id'] as String,
      city: json['city'] as String,
      attractions: json['attractions'] as String,
      days: json['days'] as String,
      prices: Map<String, String>.from(json['prices'] as Map),
      images: List<String>.from(json['images'] as List),
    );
  }

  get description => null;

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'city': city,
      'attractions': attractions,
      'days': days,
      'prices': prices,
      'images': images,
    };
  }
}
