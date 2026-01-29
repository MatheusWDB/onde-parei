import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(filteredWorksProvider);
    final List<Work> activeWorks = works
        .where((work) => !work.isFinished)
        .toList();

    return Column(
      spacing: 10.0,
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 10.0,
            ),
            prefixIcon: Icon(Icons.search),
            isDense: true,
            hintText: "Pesquisar obra...",
          ),
          style: TextStyle(),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).setQuery(value);
          },
        ),
        Expanded(
          child: activeWorks.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.menu_book, size: 45.0),
                      Text(
                        'Nenhum item salvo.',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              : ListComponent(listWorks: activeWorks),
        ),
      ],
    );
  }
}
