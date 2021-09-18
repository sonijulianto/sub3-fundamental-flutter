import 'package:dicoding_news_app/provider/search_provider.dart';
import 'package:dicoding_news_app/ui/list_page.dart';
import 'package:dicoding_news_app/widget/card_restoran.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/search';
  static const String searchTabTitle = 'Search';

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  TextEditingController searchController = new TextEditingController();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(RestaurantSearchPage.searchTabTitle),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Cari Restoran',
                border: new OutlineInputBorder(
                  borderSide:
                      new BorderSide(color: Theme.of(context).primaryColor),
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              onChanged: (String query) {
                setState(() {
                  search = query;
                });
                query.length < 3
                    ? SizedBox()
                    : context
                        .read<SearchProvider>()
                        .getRestaurantsByQuery(query);
              },
            ),
          ),
          search.trim().isNotEmpty ? showSearchResult() : showSearchGuide(),
        ],
      ),
    );
  }

  Widget showSearchResult() {
    return Consumer<SearchProvider>(
      builder: (context, provider, _) {
        switch (provider.state) {
          case ResultState.Loading:
            return Center(child: CircularProgressIndicator());
          case ResultState.HasData:
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.searchResult.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = provider.searchResult.restaurants[index];
                  return CardRestaurant(
                      restaurant: restaurant,
                      onPressed: () {
                        Navigator.pushNamed(context, ListPage.routeName,
                            arguments: restaurant);
                      });
                },
              ),
            );
          case ResultState.NoData:
            return Center(
              child: Text('Harap periksa kembalik koneksi internet anda'),
            );
          case ResultState.Error:
            return Center(
              child: Text('Harap periksa kembalik koneksi internet anda'),
            );
          default:
            return Center(child: Text(''));
        }
      },
    );
  }

  Widget showSearchGuide() {
    return Center(
      child: Text('Try to search your favorite restaurant'),
    );
  }
}
