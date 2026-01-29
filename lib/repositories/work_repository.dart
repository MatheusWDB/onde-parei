import 'package:onde_parei/data/database_helper.dart';
import 'package:onde_parei/models/work.dart';

class WorkRepository {
  final _db = DatabaseHelper.instance;
  static final tableWorks = DatabaseHelper.tableWorks;

  Future<List<Work>> findAll() async {
    final db = await _db.database;
    final result = await db.query(tableWorks);
    return result.map((e) => Work.fromMap(e)).toList();
  }

  Future<Work> insert(Work work) async {
    final db = await _db.database;
    final id = await db.insert(tableWorks, work.toMap());
    return work.copyWith(id: id);
  }

  Future<void> update(Work work) async {
    final db = await _db.database;
    await db.update(
      tableWorks,
      work.toMap(),
      where: 'id = ?',
      whereArgs: [work.id],
    );
  }

  Future<void> delete(int id) async {
    final db = await _db.database;
    await db.delete(tableWorks, where: 'id = ?', whereArgs: [id]);
  }
}
