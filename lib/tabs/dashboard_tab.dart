import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/enums/home_tab_enum.dart';
import 'package:onde_parei/enums/sort_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';
import 'package:onde_parei/providers/settings_provider.dart';
import 'package:onde_parei/providers/sort_provider.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(sortedWorksProvider);
    final sort = ref.watch(sortConfigProvider);

    final sortNotifier = ref.read(sortConfigProvider.notifier);
    final settingsNotifier = ref.read(settingsProvider.notifier);
    final searchNotifier = ref.read(searchQueryProvider.notifier);

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
                  prefixIcon: const Icon(LucideIcons.search, size: 20),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  hintText: 'Pesquisar...',
                ),
                style: const TextStyle(),
                onChanged: (value) {
                  searchNotifier.setQuery(value);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<SortField>(
                  value: sort.field,
                  iconSize: 0.0,
                  onChanged: (value) {
                    sortNotifier.changeField(value!);
                    settingsNotifier.setSortField(value);
                  },
                  items: SortField.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.displayName),
                        ),
                      )
                      .toList(),
                ),
                IconButton(
                  iconSize: 20.0,
                  onPressed: () {
                    final newDirection = sort.direction == SortDirection.asc
                        ? SortDirection.desc
                        : SortDirection.asc;

                    sortNotifier.toggleDirection();
                    settingsNotifier.setSortDirection(newDirection);
                  },
                  icon: Icon(
                    sort.direction == SortDirection.asc
                        ? LucideIcons.arrowUp
                        : LucideIcons.arrowDown,
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
                        LucideIcons.bookOpenText,
                        size: 45.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const Text(
                        'Nenhum item salvo.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              : const ListComponent(homeTab: HomeTabEnum.dashboard),
        ),
      ],
    );
  }
}
