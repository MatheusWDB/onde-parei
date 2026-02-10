import 'package:alert_info/alert_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/enums/app_theme_mode_enum.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/services/backup_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<bool?> _showConfirmImportDialog(
    BuildContext context,
  ) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar importação'),
      content: const Text(
        'Isso irá apagar todos os dados atuais e substituí-los pelo backup.\nDeseja continuar?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirmar'),
        ),
      ],
    ),
  );

  void _showBackupActions(BuildContext context, BackupService backupService) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.folderDown),
              title: const Text('Salvar em pasta'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await backupService.saveBackupToAppFolder();

                  if (!context.mounted) return;
                  
                  AlertInfo.show(
                    context: context,
                    text: 'Backup salvo com sucesso!',
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: 'Erro ao salvar backup',
                    typeInfo: TypeInfo.error,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.share2),
              title: const Text('Compartilhar'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await backupService.shareBackup();

                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: 'Backup compartilhado',
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: 'Erro ao gerar backup',
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
    WidgetRef ref,
    BackupService backupService,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.folderOpen),
              title: const Text('Usar backup do app'),
              subtitle: const Text('Arquivo salvo localmente'),
              onTap: () async {
                Navigator.pop(context);

                try {
                  final works = await backupService.importFromAppFolder();

                  if (!context.mounted) return;

                  if (works == null) {
                    AlertInfo.show(
                      context: context,
                      text: 'Nenhum backup local encontrado',
                      typeInfo: TypeInfo.warning,
                    );
                    return;
                  }

                  final confirm = await _showConfirmImportDialog(context);
                  if (confirm != true) return;

                  ref.read(workListProvider.notifier).replaceAll(works);

                  if (!context.mounted) return;

                  AlertInfo.show(
                    context: context,
                    text: 'Backup restaurado com sucesso!',
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  AlertInfo.show(
                    context: context,
                    text: 'Erro ao importar backup',
                    typeInfo: TypeInfo.error,
                  );
                }
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.search),
              title: const Text('Escolher arquivo'),
              subtitle: const Text('Buscar em outra pasta'),
              onTap: () async {
                Navigator.pop(context);

                try {
                  final works = await backupService.importBackup();
                  if (works == null) return;

                  if (!context.mounted) return;
                  final confirm = await _showConfirmImportDialog(context);
                  if (confirm != true) return;

                  ref.read(workListProvider.notifier).replaceAll(works);

                  if (!context.mounted) return;
                  AlertInfo.show(
                    context: context,
                    text: 'Backup importado com sucesso!',
                    typeInfo: TypeInfo.success,
                  );
                } catch (e) {
                  AlertInfo.show(
                    context: context,
                    text: 'Erro ao importar arquivo',
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BackupService backupService = BackupService();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configurações',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                dense: true,
                title: const Text('Tema'),
                trailing: DropdownButton<AppThemeModeEnum>(
                  value: ref.watch(settingsProvider).themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(settingsProvider.notifier).setTheme(value);
                    }
                  },
                  items: AppThemeModeEnum.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.displayName),
                        ),
                      )
                      .toList(),
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Mostar Concluídos no Início'),
                trailing: Switch(
                  value: ref.watch(settingsProvider).showCompletedOnDashboard,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).setShowCompleted(value);
                  },
                ),
              ),
              ListTile(
                dense: true,
                title: const Text('Confirmar Exclusão'),
                trailing: Switch(
                  value: ref.watch(settingsProvider).confirmBeforeDelete,
                  onChanged: (value) {
                    ref.read(settingsProvider.notifier).setConfirmDelete(value);
                  },
                ),
              ),
              /** 
              ListTile(
                dense: true,
                title: Text('Lembrar de Fazer Backup'),
                trailing: Switch(
                  value: ref.watch(settingsProvider).enableBackupReminder,
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
                    const Text(
                      'Segurança dos Dados',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const Text(
                      'O "Onde Parei?" guarda tudo localmente. Use as opções abaixo para não perder seus dados ao trocar ou formatar o dispositivo.',
                      textAlign: TextAlign.start,
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            dense: true,
                            leading: const Icon(LucideIcons.download),
                            title: const Text('Baixar backup'),
                            subtitle: const Text('Exportar seus dados'),
                            onTap: () =>
                                _showBackupActions(context, backupService),
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,
                            leading: const Icon(LucideIcons.upload),
                            title: const Text('Carregar backup'),
                            subtitle: const Text('Substituir dados atuais'),
                            onTap: () =>
                                _showImportActions(context, ref, backupService),
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
