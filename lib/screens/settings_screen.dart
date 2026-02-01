import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/services/backup_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<bool?> _showConfirmImportDialog(BuildContext context) {
    return showDialog<bool>(
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
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupService = BackupService();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configurações',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: const Text('Tema'),
                trailing: DropdownButton<AppThemeMode>(
                  value: ref.watch(settingsProvider).themeMode,
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(settingsProvider.notifier).setTheme(value);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: AppThemeMode.system,
                      child: Text('Sistema'),
                    ),
                    DropdownMenuItem(
                      value: AppThemeMode.light,
                      child: Text('Claro'),
                    ),
                    DropdownMenuItem(
                      value: AppThemeMode.dark,
                      child: Text('Escuro'),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.0,
                  children: [
                    Text(
                      'Segurança dos Dados',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'O "Onde Parei?" guarda tudo localmente. Use as opções abaixo para não perder seus dados ao trocar ou formatar o dispositivo.',
                      style: TextStyle(),
                      textAlign: TextAlign.start,
                    ),
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.download),
                            title: Text('Baixar backup'),
                            subtitle: Text('Exportar seus dados'),
                            onTap: () async {
                              await backupService.shareBackup();
                            },
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.upload),
                            title: Text('Carregar backup'),
                            subtitle: Text('Substituir dados atuais'),
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
