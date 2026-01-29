import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class CardComponent extends ConsumerWidget {
  final Work work;

  const CardComponent({super.key, required this.work});

  void _increase(WidgetRef ref) {
    ref.read(workListProvider.notifier).updateWork(work.increment());
  }

  void _decrement(WidgetRef ref) {
    ref.read(workListProvider.notifier).updateWork(work.decrement());
  }

  void _showActions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  work.isFinished ? Icons.unarchive : Icons.archive,
                ),
                title: Text(work.isFinished ? 'Desarquivar' : 'Arquivar'),
                onTap: () {
                  ref
                      .read(workListProvider.notifier)
                      .updateWork(work.copyWith(isFinished: !work.isFinished));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Excluir'),
                onTap: () {
                  ref.read(workListProvider.notifier).removeWork(work.id!);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.close),
                title: Text('Cancelar'),
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
    IconData? icon;

    if (work.isReadingType) {
      icon = Icons.menu_book_sharp;
    } else {
      icon = Icons.tv;
    }

    return InkWell(
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
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 8.0,
            children: [
              Icon(icon),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(work.title), Text(work.progressLabel)],
                ),
              ),
              work.isFinished
                  ? Row(
                      spacing: 8,
                      children: [Text('Conclúido'), Icon(Icons.verified)],
                    )
                  : Row(
                      spacing: 10.0,
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: () => _decrement(ref),
                              child: const Icon(
                                Icons.remove,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: () => _increase(ref),
                              child: const Icon(
                                Icons.add,
                                fontWeight: FontWeight.bold,
                              ),
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
