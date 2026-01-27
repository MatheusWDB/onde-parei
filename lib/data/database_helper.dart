import 'package:onde_parei/models/work.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  Future<Database> get database async {
    if (_database != null) return _database!;

    return await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'works.database');

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

  Future<Work> insertWork(Work work) async {
    Database dbWorks = await database;
    return work.copyWith(id: await dbWorks.insert(tableWorks, work.toMap()));
  }

  Future<Work?> fetchWorkById(int id) async {
    Database dbWorks = await database;
    List<Map<String, dynamic>> maps = await dbWorks.query(
      tableWorks,
      columns: [
        columnId,
        columnTitle,
        columnType,
        columnSeason,
        columnEpisode,
        columnChapter,
        columnPage,
        columnIsFinished,
        columnCreatedAt,
        columnUpdatedAt,
      ],
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;

    return Work.fromMap(maps.first);
  }

  Future<int> deleteWork(int id) async {
    Database dbWorks = await database;
    return await dbWorks.delete(
      tableWorks,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateWork(Work work) async {
    Database dbWorks = await database;
    return await dbWorks.update(
      tableWorks,
      work.toMap(),
      where: '$columnId = ?',
      whereArgs: [work.id],
    );
  }

  Future<List<Work>> fetchAllWorks() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableWorks);
    return maps.map((e) => Work.fromMap(e)).toList();
  }

  Future<int?> count() async {
    Database dbWorks = await database;
    return Sqflite.firstIntValue(
      await dbWorks.rawQuery("SELECT COUNT(*) FROM $tableWorks"),
    );
  }

  Future<void> close() async {
    Database dbWorks = await database;
    await dbWorks.close();
  }
}
