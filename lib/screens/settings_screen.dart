import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(title: Text('Configurações')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
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
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await backupService.shareBackup();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 8.0,
                        children: [Icon(Icons.download), Text('Baixar Backup')],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final works = await backupService.importBackup(ref);
                        if (works == null) return;

                        if (!context.mounted) return;
                        final confirm = await _showConfirmImportDialog(context);

                        if (confirm != true) return;
                        final notifier = ref.read(workListProvider.notifier);
                        notifier.replaceAll(works);

                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 8.0,
                        children: [Icon(Icons.upload), Text('Carregar Dados')],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
