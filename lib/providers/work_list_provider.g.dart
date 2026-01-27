// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WorkList)
final workListProvider = WorkListProvider._();

final class WorkListProvider extends $NotifierProvider<WorkList, List<Work>> {
  WorkListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workListHash();

  @$internal
  @override
  WorkList create() => WorkList();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Work> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Work>>(value),
    );
  }
}

String _$workListHash() => r'e0fe37f075e5828c78f348bc2a357b5db26e3060';

abstract class _$WorkList extends $Notifier<List<Work>> {
  List<Work> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Work>, List<Work>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Work>, List<Work>>,
              List<Work>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
