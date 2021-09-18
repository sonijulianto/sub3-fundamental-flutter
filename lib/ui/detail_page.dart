import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/detail_restaurant.dart';
import 'package:dicoding_news_app/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final Restaurant restaurant;
  DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    Widget backgroundImage() {
      return Hero(
        tag: "https://restaurant-api.dicoding.dev/images/medium/" +
            restaurant.pictureId,
        child: Container(
          width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://restaurant-api.dicoding.dev/images/medium/" +
                    restaurant.pictureId,
              ),
            ),
          ),
        ),
      );
    }

    Widget customShadow() {
      return Container(
        width: double.infinity,
        height: 214,
        margin: EdgeInsets.only(top: 136),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              whiteColor.withOpacity(0),
              Colors.black.withOpacity(0.95),
            ],
          ),
        ),
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 186),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant.name,
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          restaurant.city,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                        Text(
                          restaurant.address,
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: light,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.star,
                        color: primaryColor,
                        size: 24.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 3,
                          left: 3,
                        ),
                        child: Text(
                          restaurant.rating.toString(),
                          style: whiteTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: restaurant.categories
                        .map((e) => Container(
                              padding: EdgeInsets.all(3),
                              margin: EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: textColor),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(e.name),
                            ))
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Description',
                    style: colorTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    restaurant.description,
                    style: colorTextStyle.copyWith(
                      height: 2,
                    ),
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Menu',
                    style: colorTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onButtonTapFoods(context, restaurant);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/food.jpg'),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: textColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'Foods',
                                  style: TextStyle(
                                    fontSize: 18,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = textColor,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  'Foods',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _onButtonTapDrinks(context, restaurant);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/drink.jpg'),
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: textColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  'Drinks',
                                  style: TextStyle(
                                    fontSize: 18,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 3
                                      ..color = textColor,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  'Drinks',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Reviews',
                    style:
                        colorTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: restaurant.customerReviews
                            .map(
                              (e) => Container(
                                width: 120,
                                height: 150,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: 40),
                                        child: Text(
                                          e.name,
                                          style: blackTextStyle.copyWith(
                                            fontWeight: bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        child: Text(
                                          e.review,
                                          textAlign: TextAlign.center,
                                          style: blackTextStyle.copyWith(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        child: Text(
                                          e.date,
                                          style: blackTextStyle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList()),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            backgroundImage(),
            customShadow(),
            content(),
          ],
        ),
      ),
    );
  }
}

void _onButtonTapFoods(BuildContext context, Restaurant restaurant) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xff737373),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: buttonNavigationMenuFoods(restaurant),
            ),
          ),
        );
      });
}

Column buttonNavigationMenuFoods(Restaurant restaurant) {
  return Column(
    children: restaurant.menus.foods
        .map((food) => Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    food.name,
                    style: colorTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ))
        .toList(),
  );
}

void _onButtonTapDrinks(BuildContext context, Restaurant restaurant) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xff737373),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: buttonNavigationMenuDrinks(restaurant),
            ),
          ),
        );
      });
}

Column buttonNavigationMenuDrinks(Restaurant restaurant) {
  return Column(
    children: restaurant.menus.drinks
        .map((drink) => Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: [
                  Text(
                    drink.name,
                    style: colorTextStyle.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  Divider(),
                ],
              ),
            ))
        .toList(),
  );
}

class DetailList extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  Widget _buildList() {
    return Consumer<DetailProvider>(
      builder: (context, detailProvider, _) {
        if (detailProvider.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (detailProvider.state == ResultState.HasData) {
          var restaurant = detailProvider.result.restaurants;
          return DetailPage(restaurant: restaurant);
        } else if (detailProvider.state == ResultState.NoData) {
          return Center(
              child: Text('Harap periksa kembalik koneksi internet anda'));
        } else if (detailProvider.state == ResultState.Error) {
          return Center(
              child: Text('Data tidak dapat dimuat'));
        } else {
          return Center(child: Text('tidak ada state'));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }
}
