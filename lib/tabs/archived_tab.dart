import 'package:flutter/material.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/home_screen.dart';

class ArchivedTab extends StatefulWidget {
  const ArchivedTab({super.key, required this.listWorks});

  final List<Work> listWorks;

  @override
  State<ArchivedTab> createState() => _ArchivedTabState();
}

class _ArchivedTabState extends State<ArchivedTab> {
  @override
  Widget build(BuildContext context) {
    bool anyCompletedWorks = listWorks.any((work) => work.isFinished == true);

    return listWorks.isEmpty || !anyCompletedWorks
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
            children: [ListComponent(screen: "archived", listWorks: listWorks)],
          );
  }
}
