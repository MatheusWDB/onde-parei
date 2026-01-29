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
    final inserted = await _repository.insert(work);
    final current = state.value ?? [];
    state = AsyncData([...current, inserted]);
  }

  Future<void> updateWork(Work work) async {
    await _repository.update(work);
    final current = state.value ?? [];
    state = AsyncData(current.map((w) => w.id == work.id ? work : w).toList());
  }

  Future<void> removeWork(int id) async {
    await _repository.delete(id);
    final current = state.value ?? [];
    state = AsyncData(current.where((w) => w.id != id).toList());
  }

  Future<void> replaceAll(List<Work> works) async {
    final db = _repository;
    await db.deleteAll();

    final insertedWorks = <Work>[];

    for (final work in works) {
      final inserted = await _repository.insert(work);
      insertedWorks.add(inserted);
    }

    state = AsyncData(insertedWorks);
  }
}
