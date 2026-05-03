// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backupService)
final backupServiceProvider = BackupServiceProvider._();

final class BackupServiceProvider
    extends $FunctionalProvider<BackupService, BackupService, BackupService>
    with $Provider<BackupService> {
  BackupServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupServiceHash();

  @$internal
  @override
  $ProviderElement<BackupService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupService create(Ref ref) {
    return backupService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupService>(value),
    );
  }
}

String _$backupServiceHash() => r'0546280fad4c33bef8f92a88a091df971fcd8352';

@ProviderFor(backupReminderService)
final backupReminderServiceProvider = BackupReminderServiceProvider._();

final class BackupReminderServiceProvider
    extends
        $FunctionalProvider<
          BackupReminderService,
          BackupReminderService,
          BackupReminderService
        >
    with $Provider<BackupReminderService> {
  BackupReminderServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupReminderServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupReminderServiceHash();

  @$internal
  @override
  $ProviderElement<BackupReminderService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupReminderService create(Ref ref) {
    return backupReminderService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupReminderService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupReminderService>(value),
    );
  }
}

String _$backupReminderServiceHash() =>
    r'c9806928d08409d154ec4708773e7fba3a924263';
