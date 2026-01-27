import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/work_list_provider.dart';

class ArchivedTab extends ConsumerWidget {
  const ArchivedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(workListProvider);

    final List<Work> completedWorks = works
        .where((work) => work.isFinished)
        .toList();

    return completedWorks.isEmpty
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.menu_book, size: 45.0),
                Text(
                  'Nenhum item arquivado.',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          )
        : Column(
            children: [
              Expanded(child: ListComponent(listWorks: completedWorks)),
            ],
          );
  }
}
