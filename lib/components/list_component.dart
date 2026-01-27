import 'package:flutter/material.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/models/work.dart';

class ListComponent extends StatelessWidget {
  final List<Work> listWorks;

  const ListComponent({super.key, required this.listWorks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listWorks.length,
      itemBuilder: (context, index) {
        return CardComponent(work: listWorks[index]);
      },
    );
  }
}
