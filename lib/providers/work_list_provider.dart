import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/repositories/work_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_list_provider.g.dart';

final workRepositoryProvider = Provider((ref) => WorkRepository());

@riverpod
class WorkList extends _$WorkList {
  late final WorkRepository _repository;

  @override
  Future<List<Work>> build() async {
    try {
      _repository = ref.read(workRepositoryProvider);
      return _repository.findAll();
    } catch (e, st) {
      throw AsyncError(e, st);
    }
  }

  Future<void> addWork(Work work) async {
    final current = state.value ?? [];
    state = await AsyncValue.guard(() async {
      final inserted = await _repository.insert(work);
      return [...current, inserted];
    });
  }

  Future<void> updateWork(Work work) async {
    final current = state.value ?? [];
    state = await AsyncValue.guard(() async {
      await _repository.update(work);
      return current.map((w) => w.id == work.id ? work : w).toList();
    });
  }

  Future<void> removeWork(int id) async {
    final current = state.value ?? [];
    state = await AsyncValue.guard(() async {
      await _repository.delete(id);
      return current.where((w) => w.id != id).toList();
    });
  }

  Future<void> replaceAll(List<Work> works) async {
    state = await AsyncValue.guard(() async {
      final db = _repository;
      await db.deleteAll();

      final List<Work> insertedWorks = await Future.wait(
        works.map((work) => db.insert(work)).toList(),
      );

      return insertedWorks;
    });
  }
}
