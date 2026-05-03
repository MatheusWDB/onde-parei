import 'package:onde_parei/providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:onde_parei/enums/sort_enum.dart';

part 'sort_provider.g.dart';

@Riverpod(keepAlive: true)
class SortConfig extends _$SortConfig {
  @override
  ({SortField field, SortDirection direction}) build() {
    final settings = ref.watch(settingsProvider).value;
    return (
      field: settings?.sortField ?? SortField.title,
      direction: settings?.sortDirection ?? SortDirection.asc,
    );
  }
}
