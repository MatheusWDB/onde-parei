import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:onde_parei/enums/sort_enum.dart';

part 'sort_provider.g.dart';

@riverpod
class SortConfig extends _$SortConfig {
  @override
  ({SortField field, SortDirection direction}) build() {
    return (field: SortField.updatedAt, direction: SortDirection.desc);
  }

  void changeField(SortField field) {
    state = (field: field, direction: state.direction);
  }

  void toggleDirection() {
    state = (
      field: state.field,
      direction: state.direction == SortDirection.asc
          ? SortDirection.desc
          : SortDirection.asc
    );
  }
}
