import 'package:flutter/material.dart';

enum AppThemeMode { system, light, dark }

extension AppThemeModeX on AppThemeMode {
  ThemeMode toThemeMode() {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}

class AppSettings {
  final AppThemeMode themeMode;
  final bool confirmBeforeDelete;
  final bool showCompletedOnDashboard;
  final bool enableBackupReminder;

  const AppSettings({
    required this.themeMode,
    required this.confirmBeforeDelete,
    required this.showCompletedOnDashboard,
    required this.enableBackupReminder,
  });

  factory AppSettings.initial() => const AppSettings(
      themeMode: AppThemeMode.system,
      confirmBeforeDelete: true,
      showCompletedOnDashboard: false,
      enableBackupReminder: true,
    );

  AppSettings copyWith({
    AppThemeMode? themeMode,
    bool? confirmBeforeDelete,
    bool? showCompletedOnDashboard,
    bool? enableBackupReminder,
  }) => AppSettings(
      themeMode: themeMode ?? this.themeMode,
      confirmBeforeDelete: confirmBeforeDelete ?? this.confirmBeforeDelete,
      showCompletedOnDashboard: showCompletedOnDashboard ?? this.showCompletedOnDashboard,
      enableBackupReminder: enableBackupReminder ?? this.enableBackupReminder,
    );
}
