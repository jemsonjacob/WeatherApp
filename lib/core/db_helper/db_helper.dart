import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    final path = join(databasePath, 'weather.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather_cache (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city_name TEXT NOT NULL,
        country TEXT NOT NULL,
        temperature REAL NOT NULL,
        feels_like REAL NOT NULL,
        humidity INTEGER NOT NULL,
        wind_speed REAL NOT NULL,
        weather_main TEXT NOT NULL,
        weather_description TEXT NOT NULL,
        icon_code TEXT NOT NULL,
        last_updated TEXT NOT NULL
      )
    ''');
  }
}
