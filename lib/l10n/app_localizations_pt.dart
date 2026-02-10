// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appBackupSecurity => 'Segurança dos Dados';

  @override
  String get appBackupUsage => 'Usar backup do app';

  @override
  String get appHome => 'Início';

  @override
  String get appSettings => 'Configurações';

  @override
  String get appTheme => 'Tema';

  @override
  String get archiveSavedLocally => 'Arquivo salvo localmente';

  @override
  String get backupDownloaded => 'Backup salvo com sucesso!';

  @override
  String get backupDownloadError => 'Erro ao salvar backup';

  @override
  String get backupExport => 'Exportar seus dados';

  @override
  String get backupImported => 'Backup importado com sucesso!';

  @override
  String get backupImportError => 'Erro ao importar backup';

  @override
  String get backupLocalNotFound => 'Nenhum backup local encontrado';

  @override
  String get backupReminder => 'Lembrar de Fazer Backup';

  @override
  String get backupRestored => 'Backup restaurado com sucesso!';

  @override
  String get backupShared => 'Backup compartilhado';

  @override
  String get backupShareError => 'Erro ao gerar backup';

  @override
  String get cancel => 'Cancelar';

  @override
  String get category => 'Categoria';

  @override
  String get chapter => 'Capítulo';

  @override
  String get chooseFile => 'Escolher arquivo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get confirmDeletion => 'Confirmar Exclusão';

  @override
  String get confirmDeletionMessage =>
      'Isso irá apagar permanentemente o item.\\nDeseja continuar?';

  @override
  String get confirmImport => 'Confirmar importação';

  @override
  String get confirmImportMessage =>
      'Isso irá apagar todos os dados atuais e substituí-los pelo backup.\\nDeseja continuar?';

  @override
  String get dataSecurityInfo =>
      'O \"Onde Parei?\" guarda tudo localmente. Use as opções abaixo para não perder seus dados ao trocar ou formatar o dispositivo.';

  @override
  String get delete => 'Excluir';

  @override
  String get done => 'Concluído';

  @override
  String get downloadBackup => 'Baixar backup';

  @override
  String get edit => 'Editar';

  @override
  String get episode => 'Episódio';

  @override
  String get exampleTitle => 'Ex: Harry Potter';

  @override
  String get fileImportError => 'Erro ao importar arquivo';

  @override
  String get importBackup => 'Carregar backup';

  @override
  String get itemCompleted => 'Concluído';

  @override
  String get itemsCompleted => 'Concluídos';

  @override
  String get loadBackup => 'Carregar backup';

  @override
  String get markAsCompleted => 'Marcar como concluído';

  @override
  String get markAsIncomplete => 'Marcar como não concluído';

  @override
  String get newWork => 'Nova Obra';

  @override
  String get noItemsCompleted => 'Nenhum item concluído.';

  @override
  String get noItemsSaved => 'Nenhum item salvo.';

  @override
  String get page => 'Página';

  @override
  String get replaceCurrentData => 'Substituir dados atuais';

  @override
  String get saveChanges => 'Guardar Alterações';

  @override
  String get saveToFolder => 'Salvar em pasta';

  @override
  String get search => 'Pesquisar...';

  @override
  String get searchInAnotherFolder => 'Buscar em outra pasta';

  @override
  String get season => 'Temporada';

  @override
  String get share => 'Compartilhar';

  @override
  String get showCompletedOnHome => 'Mostar Concluídos no Início';

  @override
  String get titleOfWork => 'Título da Obra';

  @override
  String get whereDidIStop => 'Onde Parei?';

  @override
  String get zero => '0';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Escuro';

  @override
  String get typeAnime => 'Anime';

  @override
  String get typeHq => 'HQ';

  @override
  String get typeBook => 'Livro';

  @override
  String get typeManga => 'Mangá';

  @override
  String get typeManhwa => 'Manhwa';

  @override
  String get typeNovel => 'Novela';

  @override
  String get typeSeries => 'Série';

  @override
  String get sortTitle => 'Título';

  @override
  String get sortUpdatedAt => 'Atualização';

  @override
  String get sortCreatedAt => 'Criação';

  @override
  String progressReadingSimple(Object chapter) {
    return 'Cap. $chapter';
  }

  @override
  String progressReadingWithPage(Object chapter, Object page) {
    return 'Cap. $chapter • Pág. $page';
  }

  @override
  String progressWatching(Object episode, Object season) {
    return 'Temp. $season • Ep. $episode';
  }
}
