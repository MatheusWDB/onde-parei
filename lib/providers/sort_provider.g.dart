// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SortConfig)
final sortConfigProvider = SortConfigProvider._();

final class SortConfigProvider
    extends
        $NotifierProvider<
          SortConfig,
          ({SortDirection direction, SortField field})
        > {
  SortConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortConfigHash();

  @$internal
  @override
  SortConfig create() => SortConfig();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    ({SortDirection direction, SortField field}) value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({SortDirection direction, SortField field})>(
            value,
          ),
    );
  }
}

String _$sortConfigHash() => r'f523958396d56a4bd79c11e6716fcdc1340bba84';

abstract class _$SortConfig
    extends $Notifier<({SortDirection direction, SortField field})> {
  ({SortDirection direction, SortField field}) build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({SortDirection direction, SortField field}),
              ({SortDirection direction, SortField field})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({SortDirection direction, SortField field}),
                ({SortDirection direction, SortField field})
              >,
              ({SortDirection direction, SortField field}),
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
