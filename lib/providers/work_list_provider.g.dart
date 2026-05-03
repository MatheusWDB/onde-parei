// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(workRepository)
final workRepositoryProvider = WorkRepositoryProvider._();

final class WorkRepositoryProvider
    extends $FunctionalProvider<WorkRepository, WorkRepository, WorkRepository>
    with $Provider<WorkRepository> {
  WorkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workRepositoryHash();

  @$internal
  @override
  $ProviderElement<WorkRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WorkRepository create(Ref ref) {
    return workRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WorkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WorkRepository>(value),
    );
  }
}

String _$workRepositoryHash() => r'06f1941f991d9e834fbdaf08622cd8ebbfd34c48';

@ProviderFor(WorkList)
final workListProvider = WorkListProvider._();

final class WorkListProvider
    extends $AsyncNotifierProvider<WorkList, List<Work>> {
  WorkListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workListProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workListHash();

  @$internal
  @override
  WorkList create() => WorkList();
}

String _$workListHash() => r'bed57fb635ecbe680ff3ea8f61233141ad7ffb6e';

abstract class _$WorkList extends $AsyncNotifier<List<Work>> {
  FutureOr<List<Work>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Work>>, List<Work>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Work>>, List<Work>>,
              AsyncValue<List<Work>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
