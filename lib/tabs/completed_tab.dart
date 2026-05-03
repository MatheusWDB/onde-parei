import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onde_parei/components/empty_state.dart';
import 'package:onde_parei/components/work_list_view.dart';
import 'package:onde_parei/enums/home_tab_enum.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/providers/search_provider.dart';

class CompletedTab extends ConsumerWidget {
  const CompletedTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final works = ref.watch(sortedWorksProvider);
    final List<Work> completedWorks = works
        .where((work) => work.isFinished)
        .toList();

    return Column(
      children: [
        Expanded(
          child: completedWorks.isEmpty
              ? EmptyState(message: t.noItemsCompleted)
              : const WorkListView(homeTab: HomeTabEnum.completed),
        ),
      ],
    );
  }
}
