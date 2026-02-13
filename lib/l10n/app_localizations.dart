import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('pt'),
  ];

  /// No description provided for @appBackupSecurity.
  ///
  /// In pt, this message translates to:
  /// **'Segurança dos Dados'**
  String get appBackupSecurity;

  /// No description provided for @appBackupUsage.
  ///
  /// In pt, this message translates to:
  /// **'Usar backup do app'**
  String get appBackupUsage;

  /// No description provided for @appHome.
  ///
  /// In pt, this message translates to:
  /// **'Início'**
  String get appHome;

  /// No description provided for @appSettings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get appSettings;

  /// No description provided for @appTheme.
  ///
  /// In pt, this message translates to:
  /// **'Tema'**
  String get appTheme;

  /// No description provided for @archiveSavedLocally.
  ///
  /// In pt, this message translates to:
  /// **'Arquivo salvo localmente'**
  String get archiveSavedLocally;

  /// No description provided for @backupDownloaded.
  ///
  /// In pt, this message translates to:
  /// **'Backup salvo com sucesso!'**
  String get backupDownloaded;

  /// No description provided for @backupDownloadError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao salvar backup'**
  String get backupDownloadError;

  /// No description provided for @backupExport.
  ///
  /// In pt, this message translates to:
  /// **'Exportar seus dados'**
  String get backupExport;

  /// No description provided for @backupImported.
  ///
  /// In pt, this message translates to:
  /// **'Backup importado com sucesso!'**
  String get backupImported;

  /// No description provided for @backupImportError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao importar backup'**
  String get backupImportError;

  /// No description provided for @backupLocalNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum backup local encontrado'**
  String get backupLocalNotFound;

  /// No description provided for @backupReminder.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar de Fazer Backup'**
  String get backupReminder;

  /// No description provided for @backupRestored.
  ///
  /// In pt, this message translates to:
  /// **'Backup restaurado com sucesso!'**
  String get backupRestored;

  /// No description provided for @backupShared.
  ///
  /// In pt, this message translates to:
  /// **'Backup compartilhado'**
  String get backupShared;

  /// No description provided for @backupShareError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao gerar backup'**
  String get backupShareError;

  /// No description provided for @cancel.
  ///
  /// In pt, this message translates to:
  /// **'Cancelar'**
  String get cancel;

  /// No description provided for @category.
  ///
  /// In pt, this message translates to:
  /// **'Categoria'**
  String get category;

  /// No description provided for @chapter.
  ///
  /// In pt, this message translates to:
  /// **'Capítulo'**
  String get chapter;

  /// No description provided for @chooseFile.
  ///
  /// In pt, this message translates to:
  /// **'Escolher arquivo'**
  String get chooseFile;

  /// No description provided for @confirm.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar'**
  String get confirm;

  /// No description provided for @confirmDeletion.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Exclusão'**
  String get confirmDeletion;

  /// No description provided for @confirmDeletionMessage.
  ///
  /// In pt, this message translates to:
  /// **'Isso irá apagar permanentemente o item.\\nDeseja continuar?'**
  String get confirmDeletionMessage;

  /// No description provided for @confirmImport.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar importação'**
  String get confirmImport;

  /// No description provided for @confirmImportMessage.
  ///
  /// In pt, this message translates to:
  /// **'Isso irá apagar todos os dados atuais e substituí-los pelo backup.\\nDeseja continuar?'**
  String get confirmImportMessage;

  /// No description provided for @dataSecurityInfo.
  ///
  /// In pt, this message translates to:
  /// **'O \"Onde Parei?\" guarda tudo localmente. Use as opções abaixo para não perder seus dados ao trocar ou formatar o dispositivo.'**
  String get dataSecurityInfo;

  /// No description provided for @delete.
  ///
  /// In pt, this message translates to:
  /// **'Excluir'**
  String get delete;

  /// No description provided for @done.
  ///
  /// In pt, this message translates to:
  /// **'Concluído'**
  String get done;

  /// No description provided for @downloadBackup.
  ///
  /// In pt, this message translates to:
  /// **'Baixar backup'**
  String get downloadBackup;

  /// No description provided for @edit.
  ///
  /// In pt, this message translates to:
  /// **'Editar'**
  String get edit;

  /// No description provided for @episode.
  ///
  /// In pt, this message translates to:
  /// **'Episódio'**
  String get episode;

  /// No description provided for @exampleTitle.
  ///
  /// In pt, this message translates to:
  /// **'Ex: Harry Potter'**
  String get exampleTitle;

  /// No description provided for @fileImportError.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao importar arquivo'**
  String get fileImportError;

  /// No description provided for @importBackup.
  ///
  /// In pt, this message translates to:
  /// **'Carregar backup'**
  String get importBackup;

  /// No description provided for @itemCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Concluído'**
  String get itemCompleted;

  /// No description provided for @itemsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Concluídos'**
  String get itemsCompleted;

  /// No description provided for @loadBackup.
  ///
  /// In pt, this message translates to:
  /// **'Carregar backup'**
  String get loadBackup;

  /// No description provided for @markAsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Marcar como concluído'**
  String get markAsCompleted;

  /// No description provided for @markAsIncomplete.
  ///
  /// In pt, this message translates to:
  /// **'Marcar como não concluído'**
  String get markAsIncomplete;

  /// No description provided for @newWork.
  ///
  /// In pt, this message translates to:
  /// **'Nova Obra'**
  String get newWork;

  /// No description provided for @noItemsCompleted.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum item concluído.'**
  String get noItemsCompleted;

  /// No description provided for @noItemsSaved.
  ///
  /// In pt, this message translates to:
  /// **'Nenhum item salvo.'**
  String get noItemsSaved;

  /// No description provided for @page.
  ///
  /// In pt, this message translates to:
  /// **'Página'**
  String get page;

  /// No description provided for @replaceCurrentData.
  ///
  /// In pt, this message translates to:
  /// **'Substituir dados atuais'**
  String get replaceCurrentData;

  /// No description provided for @saveChanges.
  ///
  /// In pt, this message translates to:
  /// **'Guardar Alterações'**
  String get saveChanges;

  /// No description provided for @saveToFolder.
  ///
  /// In pt, this message translates to:
  /// **'Salvar em pasta'**
  String get saveToFolder;

  /// No description provided for @search.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar...'**
  String get search;

  /// No description provided for @searchInAnotherFolder.
  ///
  /// In pt, this message translates to:
  /// **'Buscar em outra pasta'**
  String get searchInAnotherFolder;

  /// No description provided for @season.
  ///
  /// In pt, this message translates to:
  /// **'Temporada'**
  String get season;

  /// No description provided for @share.
  ///
  /// In pt, this message translates to:
  /// **'Compartilhar'**
  String get share;

  /// No description provided for @showCompletedOnHome.
  ///
  /// In pt, this message translates to:
  /// **'Mostar Concluídos no Início'**
  String get showCompletedOnHome;

  /// No description provided for @titleOfWork.
  ///
  /// In pt, this message translates to:
  /// **'Título da Obra'**
  String get titleOfWork;

  /// No description provided for @whereDidIStop.
  ///
  /// In pt, this message translates to:
  /// **'Onde Parei?'**
  String get whereDidIStop;

  /// No description provided for @zero.
  ///
  /// In pt, this message translates to:
  /// **'0'**
  String get zero;

  /// No description provided for @themeSystem.
  ///
  /// In pt, this message translates to:
  /// **'Sistema'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In pt, this message translates to:
  /// **'Claro'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In pt, this message translates to:
  /// **'Escuro'**
  String get themeDark;

  /// No description provided for @typeAnime.
  ///
  /// In pt, this message translates to:
  /// **'Anime'**
  String get typeAnime;

  /// No description provided for @typeHq.
  ///
  /// In pt, this message translates to:
  /// **'HQ'**
  String get typeHq;

  /// No description provided for @typeBook.
  ///
  /// In pt, this message translates to:
  /// **'Livro'**
  String get typeBook;

  /// No description provided for @typeManga.
  ///
  /// In pt, this message translates to:
  /// **'Mangá'**
  String get typeManga;

  /// No description provided for @typeManhwa.
  ///
  /// In pt, this message translates to:
  /// **'Manhwa'**
  String get typeManhwa;

  /// No description provided for @typeNovel.
  ///
  /// In pt, this message translates to:
  /// **'Novela'**
  String get typeNovel;

  /// No description provided for @typeSeries.
  ///
  /// In pt, this message translates to:
  /// **'Série'**
  String get typeSeries;

  /// No description provided for @sortTitle.
  ///
  /// In pt, this message translates to:
  /// **'Título'**
  String get sortTitle;

  /// No description provided for @sortUpdatedAt.
  ///
  /// In pt, this message translates to:
  /// **'Atualização'**
  String get sortUpdatedAt;

  /// No description provided for @sortCreatedAt.
  ///
  /// In pt, this message translates to:
  /// **'Criação'**
  String get sortCreatedAt;

  /// No description provided for @progressReadingSimple.
  ///
  /// In pt, this message translates to:
  /// **'Cap. {chapter}'**
  String progressReadingSimple(Object chapter);

  /// No description provided for @progressReadingWithPage.
  ///
  /// In pt, this message translates to:
  /// **'Cap. {chapter} • Pág. {page}'**
  String progressReadingWithPage(Object chapter, Object page);

  /// No description provided for @progressWatching.
  ///
  /// In pt, this message translates to:
  /// **'Temp. {season} • Ep. {episode}'**
  String progressWatching(Object season, Object episode);

  /// No description provided for @neverDidBackup.
  ///
  /// In pt, this message translates to:
  /// **'Nunca fez backup'**
  String get neverDidBackup;

  /// No description provided for @lastBackup.
  ///
  /// In pt, this message translates to:
  /// **'Último backup: {date}'**
  String lastBackup(Object date);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
