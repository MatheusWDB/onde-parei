import 'package:flutter/material.dart';
import 'package:onde_parei/components/list_component.dart';
import 'package:onde_parei/enums/list_mode_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class DashboardTab extends StatefulWidget {
  final List<Work> listWorks;

  const DashboardTab({super.key, required this.listWorks});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  final TextEditingController _searchController = TextEditingController();
  late List<Work> listView;

  @override
  void initState() {
    super.initState();
    listView = [...widget.listWorks];
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
          onChanged: (value) {
            setState(() {
              listView = [
                ...widget.listWorks.where(
                  (work) =>
                      work.title.toLowerCase().contains(value.toLowerCase()),
                ),
              ];
            });
          },
        ),
        Expanded(
          child: ListComponent(
            mode: ListMode.dashboard,
            listWorks: listView,
            onUpdate: (updatedWork) {
              setState(() {
                final index = widget.listWorks.indexWhere(
                  (w) => w.id == updatedWork.id,
                );
                if (index != -1) {
                  widget.listWorks[index] = updatedWork;
                  listView = [...widget.listWorks];
                }
              });
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddOrUpdateWorkScreen()),
          ),
          child: Row(children: [Icon(Icons.add), Text("Nova Obra")]),
        ),
      ],
    );
  }
}
