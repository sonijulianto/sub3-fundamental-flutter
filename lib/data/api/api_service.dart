import 'dart:convert';
import 'package:dicoding_news_app/data/model/detail_restaurant.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/data/model/search_model.dart';
// import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String list = 'list';

  // final Client client;
  // ApiService(this.client);

  Future<RestaurantResult> getResto() async {
    final response = await http.get(Uri.parse(baseUrl + 'list'));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('gagal mendapatkan data restoran');
    }
  }
}

class ApiDetail {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  // final Client client;
  // ApiDetail(this.client);

  Future<DetailResult> listdetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return DetailResult.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Restaurant');
    }
  }
}

class SearchResto {
  static final String _baseUrl =
      'https://restaurant-api.dicoding.dev/search?q=';

  // final Client client;
  // SearchResto(this.client);

  Future<SearchResponse> restaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + query));
    if (response.statusCode == 200) {
      return SearchResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
          "Failed to Load Detail Restaurant, Please Check Your Internet");
    }
  }
}
