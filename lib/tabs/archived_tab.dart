import 'package:flutter/material.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/home_screen.dart';

class ArchivedTab extends StatefulWidget {
  const ArchivedTab({super.key, required this.ondePareiMock});

  final List<Work> ondePareiMock;

  @override
  State<ArchivedTab> createState() => _ArchivedTabState();
}

class _ArchivedTabState extends State<ArchivedTab> {
  @override
  Widget build(BuildContext context) {
    List<Work>? concluidos;
    if (ondePareiMock.any((e) => e.isFinished == true)) {
      concluidos = ondePareiMock.where((e) => e.isFinished == true).toList();
    }

    return ondePareiMock.isEmpty ||
            !ondePareiMock.any((e) => e.isFinished == true)
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
              Expanded(
                child: ListView.builder(
                  itemCount: concluidos!.length,
                  itemBuilder: (context, index) =>
                      ListComponent(mock: concluidos![index]),
                ),
              ),
            ],
          );
  }
}
