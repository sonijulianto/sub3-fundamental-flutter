import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/provider/detail_provider.dart';
import 'package:dicoding_news_app/provider/resto_provider.dart';
import 'package:dicoding_news_app/provider/search_provider.dart';
import 'package:dicoding_news_app/ui/detail_page.dart';
import 'package:dicoding_news_app/ui/favorite.dart';
import 'package:dicoding_news_app/ui/home_page.dart';
import 'package:dicoding_news_app/ui/list_page.dart';
import 'package:dicoding_news_app/ui/search_page.dart';
import 'package:dicoding_news_app/ui/splash_page.dart';
import 'package:dicoding_news_app/utils/background_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
@GenerateMocks([http.Client])
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AndroidAlarmManager.initialize();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(MyApp());
}

final client = MockClient();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestoProvider>(
          create: (_) => RestoProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<DetailProvider>(
          create: (_) => DetailProvider(
            apiService: ApiService(),
          ),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(
            apiService: ApiService(),
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: primaryColor,
        ),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: SplashPage.routeName,
        routes: {
          SplashPage.routeName: (context) => SplashPage(),
          ListPage.routeName: (context) => ListPage(),
          HomePage.routeName: (context) => HomePage(),
          DetailList.routeName: (context) => DetailList(),
          RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
