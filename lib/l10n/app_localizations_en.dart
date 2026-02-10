// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appBackupSecurity => 'Data Security';

  @override
  String get appBackupUsage => 'Use app backup';

  @override
  String get appHome => 'Home';

  @override
  String get appSettings => 'Settings';

  @override
  String get appTheme => 'Theme';

  @override
  String get archiveSavedLocally => 'File saved locally';

  @override
  String get backupDownloaded => 'Backup saved successfully!';

  @override
  String get backupDownloadError => 'Error saving backup';

  @override
  String get backupExport => 'Export your data';

  @override
  String get backupImported => 'Backup imported successfully!';

  @override
  String get backupImportError => 'Error importing backup';

  @override
  String get backupLocalNotFound => 'No local backup found';

  @override
  String get backupReminder => 'Remember to Backup';

  @override
  String get backupRestored => 'Backup restored successfully!';

  @override
  String get backupShared => 'Backup shared';

  @override
  String get backupShareError => 'Error generating backup';

  @override
  String get cancel => 'Cancel';

  @override
  String get category => 'Category';

  @override
  String get chapter => 'Chapter';

  @override
  String get chooseFile => 'Choose file';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirmDeletion => 'Confirm Deletion';

  @override
  String get confirmDeletionMessage =>
      'This will permanently delete the item.\\nDo you wish to continue?';

  @override
  String get confirmImport => 'Confirm Import';

  @override
  String get confirmImportMessage =>
      'This will erase all current data and replace it with the backup.\\nDo you wish to continue?';

  @override
  String get dataSecurityInfo =>
      'Where Did I Stop? saves everything locally. Use the options below to avoid losing your data when switching or formatting your device.';

  @override
  String get delete => 'Delete';

  @override
  String get done => 'Completed';

  @override
  String get downloadBackup => 'Download backup';

  @override
  String get edit => 'Edit';

  @override
  String get episode => 'Episode';

  @override
  String get exampleTitle => 'Ex: Harry Potter';

  @override
  String get fileImportError => 'Error importing file';

  @override
  String get importBackup => 'Load backup';

  @override
  String get itemCompleted => 'Completed';

  @override
  String get itemsCompleted => 'Completed';

  @override
  String get loadBackup => 'Load backup';

  @override
  String get markAsCompleted => 'Mark as completed';

  @override
  String get markAsIncomplete => 'Mark as incomplete';

  @override
  String get newWork => 'New Work';

  @override
  String get noItemsCompleted => 'No items completed.';

  @override
  String get noItemsSaved => 'No items saved.';

  @override
  String get page => 'Page';

  @override
  String get replaceCurrentData => 'Replace current data';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get saveToFolder => 'Save to folder';

  @override
  String get search => 'Search...';

  @override
  String get searchInAnotherFolder => 'Search in another folder';

  @override
  String get season => 'Season';

  @override
  String get share => 'Share';

  @override
  String get showCompletedOnHome => 'Show Completed on Home';

  @override
  String get titleOfWork => 'Title';

  @override
  String get whereDidIStop => 'Where Did I Stop?';

  @override
  String get zero => '0';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get typeAnime => 'Anime';

  @override
  String get typeHq => 'Comic';

  @override
  String get typeBook => 'Book';

  @override
  String get typeManga => 'Manga';

  @override
  String get typeManhwa => 'Manhwa';

  @override
  String get typeNovel => 'Novel';

  @override
  String get typeSeries => 'Series';

  @override
  String get sortTitle => 'Title';

  @override
  String get sortUpdatedAt => 'Updated';

  @override
  String get sortCreatedAt => 'Created';

  @override
  String progressReadingSimple(Object chapter) {
    return 'Ch. $chapter';
  }

  @override
  String progressReadingWithPage(Object chapter, Object page) {
    return 'Ch. $chapter • Pg. $page';
  }

  @override
  String progressWatching(Object episode, Object season) {
    return 'S. $season • Ep. $episode';
  }
}
