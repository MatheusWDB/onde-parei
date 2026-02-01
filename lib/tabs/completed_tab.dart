import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/enums/wich_screen_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';

class CompletedTab extends ConsumerWidget {
  const CompletedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final works = ref.watch(sortedWorksProvider);
    final List<Work> completedWorks = works
        .where((work) => work.isFinished)
        .toList();

    return Column(
      children: [
        Expanded(
          child: completedWorks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.menu_book,
                        size: 45.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      Text(
                        'Nenhum item concluído.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              : ListComponent(wichScreen: WichScreenEnum.archived),
        ),
      ],
    );
  }
}
