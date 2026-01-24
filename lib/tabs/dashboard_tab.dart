import 'package:flutter/material.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/models/work.dart';

class DashboardTab extends StatelessWidget {
  DashboardTab({super.key, required this.listWorks});
  final List<Work> listWorks;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.0,
      children: [
        TextField(
          controller: _searchController,
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
        ),
        ListComponent(screen: "dashboard", listWorks: listWorks),
        ElevatedButton(
          onPressed: () {},
          child: Row(children: [Icon(Icons.add), Text("Adicionar")]),
        ),
      ],
    );
  }
}
