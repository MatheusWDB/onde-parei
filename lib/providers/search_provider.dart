import 'package:onde_parei/enums/sort_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/sort_provider.dart';
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
  ref.keepAlive();
  final worksAsync = ref.watch(workListProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  return worksAsync.when(
    data: (works) {
      if (query.isEmpty) return works;
      return works.where((w) => w.title.toLowerCase().contains(query)).toList();
    },
    loading: () => const [],
    error: (_, _) => const [],
  );
}

@riverpod
List<Work> sortedWorks(Ref ref) {
  ref.keepAlive();
  final works = ref.watch(filteredWorksProvider);
  final sort = ref.watch(sortConfigProvider);

  final sorted = [...works];

  int compare(Work a, Work b) {
    int result;

    switch (sort.field) {
      case SortField.title:
        result = a.title.compareTo(b.title);
        break;

      case SortField.createdAt:
        result = (a.createdAt ?? DateTime(0)).compareTo(
          b.createdAt ?? DateTime(0),
        );
        break;

      case SortField.updatedAt:
        result = (a.updatedAt ?? DateTime(0)).compareTo(
          b.updatedAt ?? DateTime(0),
        );
        break;
    }

    return sort.direction == SortDirection.asc ? result : -result;
  }

  sorted.sort(compare);
  return sorted;
}
