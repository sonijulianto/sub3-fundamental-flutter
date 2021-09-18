import 'package:dicoding_news_app/data/model/restaurant.dart';

class SearchResponse {
  SearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<RestaurantElement> restaurants;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantElement>.from(
            json["restaurants"].map((x) => RestaurantElement.fromJson(x))),
      );
}
