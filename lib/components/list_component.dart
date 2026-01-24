import 'package:flutter/material.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/models/work.dart';

class ListComponent extends StatefulWidget {
  final List<Work> listWorks;
  final String screen;

  const ListComponent({
    super.key,
    required this.listWorks,
    required this.screen,
  });

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.listWorks.length,
        itemBuilder: (context, index) {
          bool condition = widget.screen == 'archived'
              ? !widget.listWorks[index].isFinished
              : widget.listWorks[index].isFinished;

          if (condition) {
            return SizedBox.shrink();
          }
          return CardComponent(
            work: widget.listWorks[index],
            onUpdate: (Work updatedWork) {
              setState(() {
                final originalIndex = widget.listWorks.indexWhere(
                  (work) => work.id == updatedWork.id,
                );
                if (originalIndex != -1) {
                  widget.listWorks[originalIndex] = updatedWork;
                }
              });
            },
          );
        },
      ),
    );
  }
}
