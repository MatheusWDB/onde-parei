import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class DashboardTab extends ConsumerWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(workListProvider);

    final List<Work> activeWorks = works
        .where((work) => !work.isFinished)
        .toList();

    return activeWorks.isEmpty
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
        : Column(
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
                //onChanged: (value) {},
              ),
              Expanded(child: ListComponent(listWorks: activeWorks)),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddOrUpdateWorkScreen(),
                  ),
                ),
                child: Row(children: [Icon(Icons.add), Text("Nova Obra")]),
              ),
            ],
          );
  }
}
