import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/card_component.dart';
import 'package:onde_parei/enums/wich_screen_enum.dart';
import 'package:onde_parei/models/app_settings.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';
import 'package:onde_parei/providers/settings_provider.dart';

class ListComponent extends ConsumerWidget {
  final WichScreenEnum wichScreen;

  const ListComponent({required this.wichScreen, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Work> works = ref.watch(sortedWorksProvider);
    final AppSettings settings = ref.watch(settingsProvider);

    final bool condition = wichScreen == WichScreenEnum.dashboard;

    final worksBuilder = condition
        ? settings.showCompletedOnDashboard
              ? works
              : works.where((work) => !work.isFinished).toList()
        : works.where((work) => work.isFinished).toList();

    return ListView.separated(
      itemCount: condition ? worksBuilder.length + 1 : worksBuilder.length,
      separatorBuilder: (_, _) => const SizedBox(height: 6),
      itemBuilder: (context, index) => index == worksBuilder.length && condition
            ? const SizedBox(height: 45.0)
            : CardComponent(work: worksBuilder[index]),
    );
  }
}
