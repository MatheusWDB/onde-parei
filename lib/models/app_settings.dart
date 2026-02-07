import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/enums/sort_enum.dart';

class AppSettings {
  final AppThemeModeEnum themeMode;
  final SortField sortField;
  final SortDirection sortDirection;
  final bool confirmBeforeDelete;
  final bool showCompletedOnDashboard;
  final bool enableBackupReminder;

  const AppSettings({
    required this.sortDirection,
    required this.sortField,
    required this.themeMode,
    required this.confirmBeforeDelete,
    required this.showCompletedOnDashboard,
    required this.enableBackupReminder,
  });

  factory AppSettings.initial() => const AppSettings(
    themeMode: AppThemeModeEnum.system,
    sortField: SortField.title,
    sortDirection: SortDirection.asc,
    confirmBeforeDelete: true,
    showCompletedOnDashboard: false,
    enableBackupReminder: true,
  );

  AppSettings copyWith({
    AppThemeModeEnum? themeMode,
    SortField? sortField,
    SortDirection? sortDirection,
    bool? confirmBeforeDelete,
    bool? showCompletedOnDashboard,
    bool? enableBackupReminder,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    sortField: sortField ?? this.sortField,
    sortDirection: sortDirection ?? this.sortDirection,
    confirmBeforeDelete: confirmBeforeDelete ?? this.confirmBeforeDelete,
    showCompletedOnDashboard:
        showCompletedOnDashboard ?? this.showCompletedOnDashboard,
    enableBackupReminder: enableBackupReminder ?? this.enableBackupReminder,
  );
}
