// import 'package:dicoding_news_app/data/model/restaurant.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import '../lib/data/api/api_service.dart';

// class MockClient extends Mock implements http.Client {}

// @GenerateMocks([http.Client])
// void main() {
//   group('Restaurant API Check', () {
//     test('Return List Restaurant', () async {
//       final client = MockClient();

//       when(client.get(Uri.parse(ApiService.baseUrl + ApiService.list)))
//           .thenAnswer((_) async => http.Response(
//               '{"error":false,"message":"success","count":20,"restaurants":[]}',
//               200));

//       expect(await ApiService(client).getResto(), isA<RestaurantResult>());
//     });
//   });
// }
