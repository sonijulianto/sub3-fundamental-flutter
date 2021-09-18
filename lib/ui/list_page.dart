import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/provider/resto_provider.dart';
import 'package:dicoding_news_app/ui/detail_page.dart';
import 'package:dicoding_news_app/ui/search_page.dart';
import 'package:dicoding_news_app/widget/card_restoran.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  static const routeName = '/list_restaurant';
  const ListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RestaurantSearchPage.routeName);
        },
        child: Container(
          margin: EdgeInsets.only(right: 20, bottom: 10),
          child: Icon(
            Icons.search,
            size: 40.0,
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daftar Restoran'),
        backgroundColor: primaryColor,
      ),
      body: Container(
          padding: EdgeInsets.only(
            right: 20,
            left: 20,
          ),
          child: Consumer<RestoProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.HasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(
                    restaurant: restaurant,
                    onPressed: () => Navigator.pushNamed(
                        context, DetailList.routeName,
                        arguments: restaurant),
                  );
                },
              );
            } else {
              return Center(
                  child: Text('Harap Periksa kembali koneksi internet anda'));
            }
          })),
    );
  }
}
