import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_provider.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String value) {
    state = value;
  }

  void clear() {
    state = '';
  }
}

@riverpod
List<Work> filteredWorks(Ref ref) {
  final worksAsync = ref.watch(workListProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return worksAsync.when(
    data: (works) {
      if (query.isEmpty) return works;
      return works.where((w) => w.title.toLowerCase().contains(query)).toList();
    },
    loading: () => const [],
    error: (_, __) => const [],
  );
}
