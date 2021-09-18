import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:flutter/widgets.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestoProvider extends ChangeNotifier {
  final ApiService apiService;

  RestoProvider({required this.apiService}) {
    _fetchAllArticle();
  }

  RestaurantResult? _restaurant;
  String? _message;
  ResultState? _state;

  String get message => _message!;
  RestaurantResult get result => _restaurant!;
  ResultState get state => _state!;

  Future<dynamic> _fetchAllArticle() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getResto();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'empty data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'error --> $e';
    }
  }
}
