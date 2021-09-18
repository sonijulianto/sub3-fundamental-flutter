import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:dicoding_news_app/ui/detail_page.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantElement restaurant;
  final Function() onPressed;
  const CardRestaurant({
    Key? key,
    required this.restaurant,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => Navigation.intentWithData(DetailList.routeName, restaurant),
      child: Container(
        width: double.infinity,
        height: 90,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: "https://restaurant-api.dicoding.dev/images/medium/" +
                  restaurant.pictureId,
              child: Container(
                width: 70,
                height: 70,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://restaurant-api.dicoding.dev/images/medium/" +
                          restaurant.pictureId,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    restaurant.name,
                    style: colorTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    restaurant.city,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: primaryColor,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
            SizedBox(
              width: 1,
            ),
            Text(
              restaurant.rating.toString(),
              style: colorTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
