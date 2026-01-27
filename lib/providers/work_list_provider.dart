import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'work_list_provider.g.dart';

@riverpod
class WorkList extends _$WorkList {
  @override
  List<Work> build() {
    return [
      Work(
        id: 1,
        title: 'One Piece',
        type: TypeEnum.anime,
        season: 1,
        episode: 1080,
      ),
      Work(
        id: 2,
        title: 'O Senhor dos Anéis',
        type: TypeEnum.book,
        chapter: 12,
        page: 245,
      ),
      Work(
        id: 3,
        title: 'The Bear',
        type: TypeEnum.series,
        season: 2,
        episode: 4,
      ),
      Work(
        id: 4,
        title: 'Batman: Ano Um',
        type: TypeEnum.hq,
        chapter: 2,
        page: 48,
      ),
      Work(
        id: 5,
        title: 'Berserk',
        type: TypeEnum.manga,
        chapter: 372,
        page: 12,
      ),
      Work(
        id: 6,
        title: 'It: Welcome to Derry',
        type: TypeEnum.series,
        season: 1,
        episode: 8,
        isFinished: true,
      ),
    ];
  }

  void update(Work updatedWork) {
    state = [
      for (final work in state)
        if (work.id == updatedWork.id) updatedWork else work,
    ];
  }

  void add(Work work) {
    state = [...state, work];
  }

  void remove(int id) {
    state = state.where((work) => work.id != id).toList();
  }
}
