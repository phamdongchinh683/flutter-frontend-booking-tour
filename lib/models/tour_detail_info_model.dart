import 'package:book_tour_app/models/guide_model.dart';
import 'package:book_tour_app/models/prices_model.dart';

class TourDetailInfo {
  final String id;
  final String city;
  final String attractions;
  final String days;
  final Guide guide;
  final Prices prices;
  final List<String> images;
  final String createAt;

  TourDetailInfo({
    required this.id,
    required this.city,
    required this.attractions,
    required this.days,
    required this.guide,
    required this.prices,
    required this.images,
    required this.createAt,
  });

  factory TourDetailInfo.fromJson(Map<String, dynamic> json) {
    return TourDetailInfo(
      id: json['_id'],
      city: json['city'],
      attractions: json['attractions'],
      days: json['days'],
      guide: Guide.fromJson(json['guide']),
      prices: Prices.fromJson(json['prices']),
      images: List<String>.from(json['images']),
      createAt: json['createAt'],
    );
  }
}
