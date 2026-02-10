import 'package:flutter/material.dart';
import 'package:onde_parei/l10n/app_localizations.dart';

enum AppThemeModeEnum {
  system,
  light,
  dark;

  String displayName(AppLocalizations t) {
    switch (this) {
      case AppThemeModeEnum.system:
        return t.themeSystem;
      case AppThemeModeEnum.light:
        return t.themeLight;
      case AppThemeModeEnum.dark:
        return t.themeDark;
    }
  }
}

extension AppThemeModeEnumX on AppThemeModeEnum {
  ThemeMode toThemeMode() {
    switch (this) {
      case AppThemeModeEnum.light:
        return ThemeMode.light;
      case AppThemeModeEnum.dark:
        return ThemeMode.dark;
      case AppThemeModeEnum.system:
        return ThemeMode.system;
    }
  }
}
