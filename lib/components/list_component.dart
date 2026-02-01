import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/enums/wich_screen_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';

class ListComponent extends ConsumerWidget {
  final WichScreenEnum wichScreen;

  const ListComponent({super.key, required this.wichScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(sortedWorksProvider);
    final bool condition = wichScreen == WichScreenEnum.dashboard;

    final worksBuilder = condition
        ? works.where((work) => !work.isFinished).toList()
        : works.where((work) => work.isFinished).toList();

    return ListView.separated(
      itemCount: condition ? worksBuilder.length + 1 : worksBuilder.length,
      separatorBuilder: (_, __) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        return index != worksBuilder.length
            ? CardComponent(work: worksBuilder[index])
            : condition
            ? SizedBox(height: 45.0)
            : null;
      },
    );
  }
}
