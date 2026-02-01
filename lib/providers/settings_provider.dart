import 'package:onde_parei/models/app_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

@riverpod
class Settings extends _$Settings {
  static const _themeKey = 'theme_mode';

  @override
  AppSettings build() {
    _loadFromStorage();

    return const AppSettings(
      themeMode: AppThemeMode.system,
      confirmBeforeDelete: true,
      showCompletedOnDashboard: false,
      enableBackupReminder: false,
    );
  }

  Future<void> _loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex = prefs.getInt(_themeKey);

    if (themeIndex != null) {
      state = state.copyWith(
        themeMode: AppThemeMode.values[themeIndex],
      );
    }
  }

  Future<void> setTheme(AppThemeMode mode) async {
    state = state.copyWith(themeMode: mode);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeKey, mode.index);
  }
}