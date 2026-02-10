import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/services/backup_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<bool?> _showConfirmImportDialog(
    BuildContext context,
    AppLocalizations t,
  ) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.confirmImport),
      content: Text(t.confirmImportMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(t.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(t.confirm),
        ),
      ],
    ),
  );

  void _showBackupActions(
    BuildContext context,
    BackupService backupService,
    AppLocalizations t,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.folderDown),
              title: Text(t.saveToFolder),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await backupService.saveBackupToAppFolder();

                  if (!context.mounted) return;

                  AlertInfo.show(
                    context: context,
                    text: t.backupDownloaded,
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  if (!context.mounted) return;

                  AlertInfo.show(
                    context: context,
                    text: t.backupDownloadError,
                    typeInfo: TypeInfo.error,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.share2),
              title: Text(t.share),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await backupService.shareBackup();

                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: t.backupShared,
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: t.backupShareError,
                    typeInfo: TypeInfo.error,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showImportActions(
    BuildContext context,
    WorkList listNotifier,
    BackupService backupService,
    AppLocalizations t,
  ) {
    showModalBottomSheet(
      context: context,
      // ignore: prefer_expression_function_bodies
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(LucideIcons.folderOpen),
                title: Text(t.appBackupUsage),
                subtitle: Text(t.archiveSavedLocally),
                onTap: () async {
                  try {
                    final works = await backupService.importFromAppFolder();

                    if (!context.mounted) return;

                    if (works == null) {
                      AlertInfo.show(
                        context: context,
                        text: t.backupLocalNotFound,
                        typeInfo: TypeInfo.warning,
                      );
                      return;
                    }

                    final confirm = await _showConfirmImportDialog(context, t);
                    if (confirm != true) return;

                    listNotifier.replaceAll(works);

                    if (!context.mounted) return;

                    AlertInfo.show(
                      context: context,
                      text: t.backupRestored,
                      typeInfo: TypeInfo.success,
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    AlertInfo.show(
                      context: context,
                      text: t.backupImportError,
                      typeInfo: TypeInfo.error,
                    );
                  }

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.search),
                title: Text(t.chooseFile),
                subtitle: Text(t.searchInAnotherFolder),
                onTap: () async {
                  try {
                    final works = await backupService.importBackup();
                    if (works == null) return;

                    if (!context.mounted) return;

                    final confirm = await _showConfirmImportDialog(context, t);
                    if (confirm != true) return;

                    listNotifier.replaceAll(works);

                    if (!context.mounted) return;

                    AlertInfo.show(
                      context: context,
                      text: t.backupImported,
                      typeInfo: TypeInfo.success,
                    );

                    Navigator.pop(context);
                  } catch (e) {
                    AlertInfo.show(
                      context: context,
                      text: t.fileImportError,
                      typeInfo: TypeInfo.error,
                    );
                  }

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final BackupService backupService = BackupService();
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.appSettings,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: Text(t.appTheme),
                trailing: DropdownButton<AppThemeModeEnum>(
                  value: settings.themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      settingsNotifier.setTheme(value);
                    }
                  },
                  items: AppThemeModeEnum.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.displayName(t)),
                        ),
                      )
                      .toList(),
                ),
              ),
              ListTile(
                dense: true,
                title: Text(t.showCompletedOnHome),
                trailing: Switch(
                  value: settings.showCompletedOnDashboard,
                  onChanged: (value) {
                    settingsNotifier.setShowCompleted(value);
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: Text(t.confirmDeletion),
                trailing: Switch(
                  value: settings.confirmBeforeDelete,
                  onChanged: (value) {
                    settingsNotifier.setConfirmDelete(value);
                  },
                ),
              ),
              /** 
              ListTile(
                dense: true,
                title: Text(t.backupReminder),
                trailing: Switch(
                  value: settings.enableBackupReminder,
                  onChanged: (value) {
                    ref
                        .read(settingsProvider.notifier)
                        .setBackupReminder(value);
                  },
                ),
              ),*/
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.0,
                  children: [
                    Text(
                      t.appBackupSecurity,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(t.dataSecurityInfo, textAlign: TextAlign.start),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            leading: const Icon(LucideIcons.download),
                            title: Text(t.downloadBackup),
                            subtitle: Text(t.backupExport),
                            onTap: () =>
                                _showBackupActions(context, backupService, t),
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,
                            leading: const Icon(LucideIcons.upload),
                            title: Text(t.loadBackup),
                            subtitle: Text(t.replaceCurrentData),
                            onTap: () => _showImportActions(
                              context,
                              ref.read(workListProvider.notifier),
                              backupService,
                              t,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
