import 'package:onde_parei/l10n/app_localizations.dart';

enum SortField {
  title,
  updatedAt,
  createdAt;

  String displayName(AppLocalizations t) {
    switch (this) {
      case SortField.title:
        return t.sortTitle;
      case SortField.updatedAt:
        return t.sortUpdatedAt;
      case SortField.createdAt:
        return t.sortCreatedAt;
    }
  }
}

enum SortDirection { asc, desc }
