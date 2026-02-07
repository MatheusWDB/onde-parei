import 'package:onde_parei/enums/app_theme_mode_enum.dart';

class AppSettings {
  final AppThemeModeEnum themeMode;
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
    themeMode: AppThemeModeEnum.system,
    confirmBeforeDelete: true,
    showCompletedOnDashboard: false,
    enableBackupReminder: true,
  );

  AppSettings copyWith({
    AppThemeModeEnum? themeMode,
    bool? confirmBeforeDelete,
    bool? showCompletedOnDashboard,
    bool? enableBackupReminder,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    confirmBeforeDelete: confirmBeforeDelete ?? this.confirmBeforeDelete,
    showCompletedOnDashboard:
        showCompletedOnDashboard ?? this.showCompletedOnDashboard,
    enableBackupReminder: enableBackupReminder ?? this.enableBackupReminder,
  );
}
