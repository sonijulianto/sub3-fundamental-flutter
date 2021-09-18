import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/detail_restaurant.dart';
import 'package:flutter/cupertino.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final Restaurant? id;

  DetailProvider({
    required this.apiService,
    this.id
  }) {
    fetchAllDetail(id?.id);
  }

  late DetailResult _detailsResult;
  String _message = '';
  ResultState? _state;

  String get message => _message;

  DetailResult get result => _detailsResult;

  ResultState? get state => _state;

  Future<dynamic> fetchAllDetail(id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final listdetail = ApiDetail().listdetail(id);
      final restaurant = await listdetail;
      if (restaurant.restaurants.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detailsResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
