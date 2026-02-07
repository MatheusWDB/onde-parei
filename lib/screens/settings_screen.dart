import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupService = BackupService();

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
                  items: AppThemeModeEnum.values.map((e) => DropdownMenuItem(value: e, child: Text(e.displayName))).toList(),
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
                            leading: const Icon(Icons.download),
                            title: const Text('Baixar backup'),
                            subtitle: const Text('Exportar seus dados'),
                            onTap: () async {
                              await backupService.shareBackup();
                            },
                          ),
                          const Divider(),
                          ListTile(
                            dense: true,
                            leading: const Icon(Icons.upload),
                            title: const Text('Carregar backup'),
                            subtitle: const Text('Substituir dados atuais'),
                            onTap: () async {
                              final works = await backupService.importBackup(
                                ref,
                              );
                              if (works == null) return;

                              if (!context.mounted) return;
                              final confirm = await _showConfirmImportDialog(
                                context,
                              );

                              if (confirm != true) return;
                              final notifier = ref.read(
                                workListProvider.notifier,
                              );
                              notifier.replaceAll(works);

                              if (!context.mounted) return;
                              Navigator.pop(context);
                            },
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
