import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/enums/sort_enum.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:onde_parei/providers/backup_service_provider.dart';
import 'package:onde_parei/services/backup_reminder_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  late final SharedPreferences _prefs;

  static const _themeKey = 'theme_mode';
  static const _sortFieldKey = 'sort_field';
  static const _sortDirectionKey = 'sort_direction';
  static const _lastBackupKey = 'last_backup_at';
  static const _confirmKey = 'confirm_before_delete';
  static const _reminderKey = 'reminder_backup';

  late final BackupReminderService _reminderService;

  @override
  Future<AppSettings> build() async {
    _prefs = await SharedPreferences.getInstance();
    _reminderService = ref.read(backupReminderServiceProvider);

    final themeIndex = _prefs.getInt(_themeKey);
    final sortFieldIndex = _prefs.getInt(_sortFieldKey);
    final sortDirectionIndex = _prefs.getInt(_sortDirectionKey);
    final lastBackupMillis = _prefs.getInt(_lastBackupKey);
    final confirm = _prefs.getBool(_confirmKey);
    final reminder = _prefs.getBool(_reminderKey);

    return AppSettings(
      themeMode: themeIndex != null
          ? AppThemeModeEnum.values[themeIndex]
          : AppThemeModeEnum.system,
      sortField: sortFieldIndex != null
          ? SortField.values[sortFieldIndex]
          : SortField.title,
      sortDirection: sortDirectionIndex != null
          ? SortDirection.values[sortDirectionIndex]
          : SortDirection.asc,
      lastBackupAt: lastBackupMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(lastBackupMillis)
          : null,
      confirmBeforeDelete: confirm ?? true,
      enableBackupReminder: reminder ?? false,
    );
  }

  Future<void> _update(
    AppSettings Function(AppSettings current) updater,
  ) async {
    final current = await future;
    state = AsyncData(updater(current));
  }

  Future<void> setTheme(AppThemeModeEnum mode) async {
    await _update((s) => s.copyWith(themeMode: mode));
    _prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setSortField(SortField sortField) async {
    await _update((s) => s.copyWith(sortField: sortField));
    _prefs.setInt(_sortFieldKey, sortField.index);
  }

  Future<void> setSortDirection(SortDirection sortDirection) async {
    await _update((s) => s.copyWith(sortDirection: sortDirection));
    _prefs.setInt(_sortDirectionKey, sortDirection.index);
  }

  Future<void> setLastBackup({
    required DateTime date,
    required String title,
    required String body,
  }) async {
    await _update((s) => s.copyWith(lastBackupAt: date));
    await _prefs.setInt(_lastBackupKey, date.millisecondsSinceEpoch);

    final current = await future;
    if (current.enableBackupReminder) {
      await _reminderService.rescheduleAfterBackup(
        date,
        title: title,
        body: body,
      );
    }
  }

  Future<void> setConfirmDelete(bool confirm) async {
    await _update((s) => s.copyWith(confirmBeforeDelete: confirm));
    _prefs.setBool(_confirmKey, confirm);
  }

  Future<void> setBackupReminder(
    bool reminder, {
    required String title,
    required String body,
  }) async {
    await _update((s) => s.copyWith(enableBackupReminder: reminder));
    await _prefs.setBool(_reminderKey, reminder);

    final current = await future;
    if (reminder) {
      await _reminderService.scheduleFromSettings(
        current,
        title: title,
        body: body,
      );
    } else {
      await _reminderService.cancel();
    }
  }
}
