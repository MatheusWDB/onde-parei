import 'package:onde_parei/models/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  late final SharedPreferences _prefs;
  static const _themeKey = 'theme_mode';
  static const _confirmKey = 'confirm_delete';
  static const _showCompletedKey = 'show_completed';
  static const _reminderKey = 'reminder_backup';

  @override
  AppSettings build() {
    ref.keepAlive();
    _init();
    _loadFromStorage();

    return const AppSettings(
      themeMode: AppThemeMode.system,
      confirmBeforeDelete: true,
      showCompletedOnDashboard: false,
      enableBackupReminder: false,
    );
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromStorage() async {
    final themeIndex = _prefs.getInt(_themeKey);
    final confirm = _prefs.getBool(_confirmKey);
    final showCompleted = _prefs.getBool(_showCompletedKey);
    final reminder = _prefs.getBool(_reminderKey);

    state = state.copyWith(
      themeMode: themeIndex != null
          ? AppThemeMode.values[themeIndex]
          : state.themeMode,
      confirmBeforeDelete: confirm ?? state.confirmBeforeDelete,
      showCompletedOnDashboard: showCompleted ?? state.showCompletedOnDashboard,
      enableBackupReminder: reminder ?? state.enableBackupReminder,
    );
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = state.copyWith(themeMode: mode);

    await _prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setConfirmDelete(bool confirm) async {
    state = state.copyWith(confirmBeforeDelete: confirm);

    await _prefs.setBool(_confirmKey, confirm);
  }

  Future<void> setShowCompleted(bool completed) async {
    state = state.copyWith(showCompletedOnDashboard: completed);

    await _prefs.setBool(_showCompletedKey, completed);
  }

  Future<void> setBackupReminder(bool reminder) async {
    state = state.copyWith(enableBackupReminder: reminder);

    await _prefs.setBool(_reminderKey, reminder);
  }
}
