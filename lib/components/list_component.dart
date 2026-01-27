import 'package:flutter/material.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/enums/list_mode_enum.dart';
import 'package:onde_parei/models/work.dart';

class ListComponent extends StatelessWidget {
  final List<Work> listWorks;
  final ListMode mode;
  final ValueChanged<Work> onUpdate;

  const ListComponent({
    super.key,
    required this.listWorks,
    required this.mode,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listWorks.length,
      itemBuilder: (context, index) {
        bool condition = mode == ListMode.archived
            ? !listWorks[index].isFinished
            : listWorks[index].isFinished;
    
        if (condition) {
          return SizedBox.shrink();
        }
        return CardComponent(work: listWorks[index], onUpdate: onUpdate);
      },
    );
  }
}
