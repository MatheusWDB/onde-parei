import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String tableWorks = 'works';
  
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnType = 'type';
  static const String columnSeason = 'season';
  static const String columnEpisode = 'episode';
  static const String columnChapter = 'chapter';
  static const String columnPage = 'page';
  static const String columnIsFinished = 'isFinished';
  static const String columnCreatedAt = 'createdAt';
  static const String columnUpdatedAt = 'updatedAt';

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'works.database');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database database, int version) async {
    await database.execute(_works);
  }

  String get _works =>
      '''
          CREATE TABLE $tableWorks (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnTitle TEXT NOT NULL,
            $columnType INTEGER NOT NULL,
            $columnSeason INTEGER,
            $columnEpisode INTEGER,
            $columnChapter REAL,
            $columnPage INTEGER,
            $columnIsFinished INTEGER NOT NULL,
            $columnCreatedAt TEXT NOT NULL,
            $columnUpdatedAt TEXT
          );
      ''';
}
