import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/data/model/search_model.dart';
import 'package:flutter/material.dart';

enum ResultState { Loading, NoData, HasData, Error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService});

  RestaurantResult? _restaurant;
  SearchResponse? _searchResult;
  String? _message = '';
  ResultState? _state;

  RestaurantResult get result => _restaurant!;
  SearchResponse get searchResult => _searchResult!;
  String get message => _message!;
  ResultState get state => _state!;

  void getRestaurants() {
    _doCall();
  }

  void getRestaurantsByQuery(String query) {
    _doCall(query: query);
  }

  void _doCall({String query = ''}) {
    _state = ResultState.Loading;
    notifyListeners();

    Future<dynamic> result;
    if (query.isEmpty) {
      result = _getRestaurantList();
    } else {
      result = _searchRestaurant(query);
    }

    result.then((value) {
      if (query.isEmpty) {
        _restaurant = value;
      } else {
        _searchResult = value;
      }
    });
  }

  Future<dynamic> _getRestaurantList() async {
    try {
      final restaurantResponse = await apiService.getResto();
      if ((restaurantResponse.count == 0) ||
          (restaurantResponse.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return restaurantResponse;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }

  Future<dynamic> _searchRestaurant(String query) async {
    try {
      final restaurantSearch = SearchResto().restaurantSearch(query);
      final searchResponses = await restaurantSearch;
      if ((searchResponses.founded == 0) ||
          (searchResponses.restaurants.isEmpty)) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return searchResponses;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
