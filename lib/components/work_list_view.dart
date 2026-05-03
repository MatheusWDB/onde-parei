import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/work_card.dart';
import 'package:onde_parei/enums/home_tab_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';

class WorkListView extends ConsumerWidget {
  final HomeTabEnum homeTab;

  const WorkListView({required this.homeTab, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(sortedWorksProvider);

    final bool isDashboard = homeTab == HomeTabEnum.dashboard;

    final worksBuilder = isDashboard
        ? works.where((work) => !work.isFinished).toList()
        : works.where((work) => work.isFinished).toList();

    return ListView.separated(
      itemCount: isDashboard ? worksBuilder.length + 1 : worksBuilder.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (context, index) =>
          index == worksBuilder.length && isDashboard
          ? const SizedBox(height: 45.0)
          : WorkCard(
              key: ValueKey(worksBuilder[index].id),
              work: worksBuilder[index],
            ),
    );
  }
}
