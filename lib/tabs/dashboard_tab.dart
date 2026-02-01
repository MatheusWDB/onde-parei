import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/enums/sort_enum.dart';
import 'package:onde_parei/enums/wich_screen_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';
import 'package:onde_parei/providers/sort_provider.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(sortedWorksProvider);
    final List<Work> activeWorks = works
        .where((work) => !work.isFinished)
        .toList();

    return Column(
      spacing: 10.0,
      children: [
        Row(
          spacing: 10.0,
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  prefixIcon: Icon(Icons.search, size: 20),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  hintText: "Pesquisar...",
                ),
                style: TextStyle(),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).setQuery(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<SortField>(
                  value: ref.watch(sortConfigProvider).field,
                  iconSize: 0.0,
                  onChanged: (value) {
                    ref.read(sortConfigProvider.notifier).changeField(value!);
                  },
                  items: const [
                    DropdownMenuItem(
                      value: SortField.updatedAt,
                      child: Text('Atualização'),
                    ),
                    DropdownMenuItem(
                      value: SortField.createdAt,
                      child: Text('Criação'),
                    ),
                    DropdownMenuItem(
                      value: SortField.title,
                      child: Text('Título'),
                    ),
                  ],
                ),
                IconButton(
                  iconSize: 20.0,
                  onPressed: () {
                    ref.read(sortConfigProvider.notifier).toggleDirection();
                  },
                  icon: Icon(
                    ref.watch(sortConfigProvider).direction == SortDirection.asc
                        ? Icons.arrow_upward
                        : Icons.arrow_downward,
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: activeWorks.isEmpty
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
                        'Nenhum item salvo.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              : ListComponent(wichScreen: WichScreenEnum.dashboard),
        ),
      ],
    );
  }
}
