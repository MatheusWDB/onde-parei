// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workListHash();

  @$internal
  @override
  WorkList create() => WorkList();
}

String _$workListHash() => r'0355f6c24e3a20751372752d3febb4ba75e68ce5';

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
