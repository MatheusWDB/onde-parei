// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchQuery)
final searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'28fd835cc33dcb38ecedad2077724d0f43e2d189';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredWorks)
final filteredWorksProvider = FilteredWorksProvider._();

final class FilteredWorksProvider
    extends $FunctionalProvider<List<Work>, List<Work>, List<Work>>
    with $Provider<List<Work>> {
  FilteredWorksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredWorksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredWorksHash();

  @$internal
  @override
  $ProviderElement<List<Work>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Work> create(Ref ref) {
    return filteredWorks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Work> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Work>>(value),
    );
  }
}

String _$filteredWorksHash() => r'8b38a1ca5115a0daa06f0fe882642ba13951348c';

@ProviderFor(sortedWorks)
final sortedWorksProvider = SortedWorksProvider._();

final class SortedWorksProvider
    extends $FunctionalProvider<List<Work>, List<Work>, List<Work>>
    with $Provider<List<Work>> {
  SortedWorksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedWorksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedWorksHash();

  @$internal
  @override
  $ProviderElement<List<Work>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Work> create(Ref ref) {
    return sortedWorks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Work> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Work>>(value),
    );
  }
}

String _$sortedWorksHash() => r'e1c12a954255928027d6767712cd44b6ed98d656';
