// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appBackupSecurity => 'Seguridad de Datos';

  @override
  String get appBackupUsage => 'Usar copia de seguridad';

  @override
  String get appHome => 'Inicio';

  @override
  String get appSettings => 'Configuración';

  @override
  String get appTheme => 'Tema';

  @override
  String get archiveSavedLocally => 'Archivo guardado localmente';

  @override
  String get backupDownloaded => '¡Copia de seguridad guardada con éxito!';

  @override
  String get backupDownloadError => 'Error al guardar la copia de seguridad';

  @override
  String get backupExport => 'Exportar tus datos';

  @override
  String get backupImported => '¡Copia de seguridad importada con éxito!';

  @override
  String get backupImportError => 'Error al importar la copia de seguridad';

  @override
  String get backupLocalNotFound =>
      'No se encontró ninguna copia de seguridad local';

  @override
  String get backupReminder => 'Recordar hacer copia de seguridad';

  @override
  String get backupRestored => 'Copia de seguridad restaurada con éxito';

  @override
  String get backupShared => 'Copia de seguridad compartida';

  @override
  String get backupShareError => 'Error al generar la copia de seguridad';

  @override
  String get cancel => 'Cancelar';

  @override
  String get category => 'Categoría';

  @override
  String get chapter => 'Capítulo';

  @override
  String get chooseFile => 'Elegir archivo';

  @override
  String get confirm => 'Confirmar';

  @override
  String get confirmDeletion => 'Confirmar eliminación';

  @override
  String get confirmDeletionMessage =>
      'Esto eliminará permanentemente el elemento.\\n¿Deseas continuar?';

  @override
  String get confirmImport => 'Confirmar importación';

  @override
  String get confirmImportMessage =>
      'Esto borrará todos los datos actuales y los reemplazará por la copia de seguridad.\\n¿Deseas continuar?';

  @override
  String get dataSecurityInfo =>
      'Where Did I Stop? guarda todo localmente. Usa las opciones a continuación para no perder tus datos al cambiar o formatear el dispositivo.';

  @override
  String get delete => 'Eliminar';

  @override
  String get done => 'Completado';

  @override
  String get downloadBackup => 'Descargar copia de seguridad';

  @override
  String get edit => 'Editar';

  @override
  String get episode => 'Episodio';

  @override
  String get exampleTitle => 'Ej: Harry Potter';

  @override
  String get fileImportError => 'Error al importar el archivo';

  @override
  String get importBackup => 'Cargar copia de seguridad';

  @override
  String get itemCompleted => 'Completado';

  @override
  String get itemsCompleted => 'Completados';

  @override
  String get loadBackup => 'Cargar copia de seguridad';

  @override
  String get markAsCompleted => 'Marcar como completado';

  @override
  String get markAsIncomplete => 'Marcar como no completado';

  @override
  String get newWork => 'Nueva obra';

  @override
  String get noItemsCompleted => 'No hay elementos completados.';

  @override
  String get noItemsSaved => 'No hay elementos guardados.';

  @override
  String get page => 'Página';

  @override
  String get replaceCurrentData => 'Reemplazar datos actuales';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get saveToFolder => 'Guardar en carpeta';

  @override
  String get search => 'Buscar...';

  @override
  String get searchInAnotherFolder => 'Buscar en otra carpeta';

  @override
  String get season => 'Temporada';

  @override
  String get share => 'Compartir';

  @override
  String get showCompletedOnHome => 'Mostrar completados en inicio';

  @override
  String get titleOfWork => 'Título de la obra';

  @override
  String get whereDidIStop => 'Where Did I Stop?';

  @override
  String get zero => '0';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get typeAnime => 'Anime';

  @override
  String get typeHq => 'Cómic';

  @override
  String get typeBook => 'Libro';

  @override
  String get typeManga => 'Manga';

  @override
  String get typeManhwa => 'Manhwa';

  @override
  String get typeNovel => 'Novela';

  @override
  String get typeSeries => 'Serie';

  @override
  String get sortTitle => 'Título';

  @override
  String get sortUpdatedAt => 'Actualización';

  @override
  String get sortCreatedAt => 'Creación';

  @override
  String progressReadingSimple(Object chapter) {
    return 'Cap. $chapter';
  }

  @override
  String progressReadingWithPage(Object chapter, Object page) {
    return 'Cap. $chapter • Pág. $page';
  }

  @override
  String progressWatching(Object season, Object episode) {
    return 'T. $season • Ep. $episode';
  }

  @override
  String get neverDidBackup => 'Nunca hizo una copia de seguridad';

  @override
  String lastBackup(Object date) {
    return 'Último respaldo: $date';
  }
}
