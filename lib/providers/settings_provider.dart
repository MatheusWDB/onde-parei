import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/enums/sort_enum.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:onde_parei/services/backup_reminder_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  static const _themeKey = 'theme_mode';
  static const _sortFieldKey = 'sort_field';
  static const _sortDirectionKey = 'sort_direction';
  static const _lastBackupKey = 'last_backup_at';
  static const _confirmKey = 'confirm_delete';
  static const _showCompletedKey = 'show_completed';
  static const _reminderKey = 'reminder_backup';

  final _reminderService = BackupReminderService();

  @override
  AppSettings build() {
    ref.keepAlive();

    _loadFromStorage();

    return const AppSettings(
      themeMode: AppThemeModeEnum.system,
      confirmBeforeDelete: true,
      showCompletedOnDashboard: false,
      enableBackupReminder: false,
      sortDirection: SortDirection.asc,
      sortField: SortField.title,
    );
  }

  Future<void> _loadFromStorage() async {
    final prefs = await _prefs;

    final themeIndex = prefs.getInt(_themeKey);
    final sortFieldIndex = prefs.getInt(_sortFieldKey);
    final sortDirectionIndex = prefs.getInt(_sortDirectionKey);
    final lastBackupMillis = prefs.getInt(_lastBackupKey);
    final confirm = prefs.getBool(_confirmKey);
    final showCompleted = prefs.getBool(_showCompletedKey);
    final reminder = prefs.getBool(_reminderKey);

    state = state.copyWith(
      themeMode: themeIndex != null
          ? AppThemeModeEnum.values[themeIndex]
          : state.themeMode,
      sortField: sortFieldIndex != null
          ? SortField.values[sortFieldIndex]
          : state.sortField,
      sortDirection: sortDirectionIndex != null
          ? SortDirection.values[sortDirectionIndex]
          : state.sortDirection,
      lastBackupAt: lastBackupMillis != null
          ? DateTime.fromMillisecondsSinceEpoch(lastBackupMillis)
          : null,
      confirmBeforeDelete: confirm ?? state.confirmBeforeDelete,
      showCompletedOnDashboard: showCompleted ?? state.showCompletedOnDashboard,
      enableBackupReminder: reminder ?? state.enableBackupReminder,
    );
  }

  Future<void> setTheme(AppThemeModeEnum mode) async {
    final prefs = await _prefs;
    state = state.copyWith(themeMode: mode);

    await prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setSortField(SortField sortField) async {
    final prefs = await _prefs;
    state = state.copyWith(sortField: sortField);

    await prefs.setInt(_sortFieldKey, sortField.index);
  }

  Future<void> setSortDirection(SortDirection sortDirection) async {
    final prefs = await _prefs;
    state = state.copyWith(sortDirection: sortDirection);

    await prefs.setInt(_sortDirectionKey, sortDirection.index);
  }

  Future<void> setLastBackup(DateTime date) async {
    final prefs = await _prefs;
    state = state.copyWith(lastBackupAt: date);

    await prefs.setInt(_lastBackupKey, date.millisecondsSinceEpoch);

    if (state.enableBackupReminder) _reminderService.scheduleIfNeeded(state);
  }

  Future<void> setConfirmDelete(bool confirm) async {
    final prefs = await _prefs;
    state = state.copyWith(confirmBeforeDelete: confirm);

    await prefs.setBool(_confirmKey, confirm);
  }

  Future<void> setShowCompleted(bool completed) async {
    final prefs = await _prefs;
    state = state.copyWith(showCompletedOnDashboard: completed);

    await prefs.setBool(_showCompletedKey, completed);
  }

  Future<void> setBackupReminder(bool reminder) async {
    final prefs = await _prefs;
    state = state.copyWith(enableBackupReminder: reminder);

    await prefs.setBool(_reminderKey, reminder);

    reminder
        ? _reminderService.scheduleIfNeeded(state)
        : _reminderService.cancel();
  }
}
