import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class CardComponent extends ConsumerWidget {
  final Work work;

  const CardComponent({required this.work, super.key});

  void _increase(WidgetRef ref) {
    ref.read(workListProvider.notifier).updateWork(work.increment());
  }

  void _decrement(WidgetRef ref) {
    ref.read(workListProvider.notifier).updateWork(work.decrement());
  }

  Future<bool?> _showConfirmDelete(BuildContext context) => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Confirmar Exclusão'),
      content: const Text(
        'Isso irá apagar permanentemente o item.\nDeseja continuar?',
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

  void _showActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (_) {
        final AppSettings settings = ref.watch(settingsProvider);

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  work.isFinished ? LucideIcons.undo2 : LucideIcons.circleCheckBig,
                ),
                title: Text(
                  work.isFinished
                      ? 'Marcar como não concluído'
                      : 'Marcar como concluído',
                ),
                onTap: () {
                  ref
                      .read(workListProvider.notifier)
                      .updateWork(work.copyWith(isFinished: !work.isFinished));

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.trash2),
                title: const Text('Excluir'),
                onTap: () async {
                  if (settings.confirmBeforeDelete) {
                    final bool? confirm = await _showConfirmDelete(context);
                    if (confirm != true) return;
                  }
                  ref.read(workListProvider.notifier).removeWork(work.id!);

                  if (!context.mounted) return;

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(LucideIcons.x),
                title: const Text('Cancelar'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IconData icon = work.isReadingType
        ? LucideIcons.bookOpen
        : LucideIcons.tv;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateWorkScreen(work: work),
        ),
      ),
      onLongPress: () {
        HapticFeedback.mediumImpact();
        _showActions(context, ref);
      },
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 8.0,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      work.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      work.type.displayName,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      work.progressLabel,
                      style: TextStyle(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              work.isFinished
                  ? const Row(
                      spacing: 8,
                      children: [
                        Text('Conclúido'),
                        Icon(LucideIcons.circleCheck),
                      ],
                    )
                  : Row(
                      spacing: 10.0,
                      children: [
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              return _decrement(ref);
                            },
                            icon: Icon(
                              LucideIcons.minus,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.secondary,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              HapticFeedback.selectionClick();
                              return _increase(ref);
                            },
                            icon: Icon(
                              LucideIcons.plus,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
