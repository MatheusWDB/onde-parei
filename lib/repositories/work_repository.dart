import 'package:onde_parei/data/database_helper.dart';
import 'package:onde_parei/models/work.dart';
import 'package:sqflite/sqflite.dart';

class WorkRepository {
  static const _table = DatabaseHelper.tableWorks;

  Future<Database> get _db => DatabaseHelper.instance.database;

  Future<List<Work>> findAll() async {
    final maps = await (await _db).query(_table);
    return maps.map(Work.fromMap).toList();
  }

  Future<Work> insert(Work work) async {
    final id = await (await _db).insert(_table, work.toMap());
    return work.copyWith(id: id);
  }

  Future<void> update(Work work) async {
    await (await _db).update(
      _table,
      work.toMap(),
      where: 'id = ?',
      whereArgs: [work.id],
    );
  }

  Future<void> delete(int id) async {
    await (await _db).delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    await (await _db).delete(_table);
  }
}
