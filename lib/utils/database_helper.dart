// import 'package:dicoding_news_app/data/model/restaurant.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DatabaseHelper {
//   static DatabaseHelper? _databaseHelper;
//   static late Database _database;

//   DatabaseHelper._internal() {
//     _databaseHelper = this;
//   }

//   factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

//   Future<Database> get database async {
//     _database = await _initializeDb();
//     return _database;
//   }

//   static String _tableName = 'resto';

//   Future<Database> _initializeDb() async {
//     var path = await getDatabasesPath();
//     var db = openDatabase(
//       join(path, 'note_db.db'),
//       onCreate: (db, version) async {
//         await db.execute(
//           '''CREATE TABLE $_tableName (
//             id INTEGER PRIMARY KEY,
//             title TEXT, description TEXT
//           )''',
//         );
//       },
//       version: 1,
//     );
//     return db;
//   }

//   Future<Database> get databases async {
//     _database = await _initializeDb();
//     return _database;
//   }

//   Future<void> insertResto(RestaurantElement restaurant) async {
//     final Database db = await database;
//     await db.insert(_tableName, restaurant.toJson());
//     print('Data saved');
//   }

//   Future<List<RestaurantElement>> getResto() async {
//     final Database db = await database;
//     List<Map<String, dynamic>> results = await db.query(_tableName);

//     return results.map((res) => RestaurantElement.fromJson(res)).toList();
//   }

//   Future<RestaurantElement> getRestoById(int id) async {
//     final Database db = await database;
//     List<Map<String, dynamic>> results = await db.query(
//       _tableName,
//       where: 'id = ?',
//       whereArgs: [id],
//     );

//     return results.map((res) => RestaurantElement.fromJson(res)).first;
//   }

//   Future<void> updateResto(RestaurantElement restaurant) async {
//     final db = await database;

//     await db.update(
//       _tableName,
//       restaurant.toJson(),
//       where: 'id = ?',
//       whereArgs: [restaurant.id],
//     );
//   }

//   Future<void> deleteResto(int id) async {
//     final db = await database;

//     await db.delete(
//       _tableName,
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
