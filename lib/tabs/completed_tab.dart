import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/components/list_component.dart';
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
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        LucideIcons.bookOpenText,
                        size: 45.0,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      Text(
                        t.noItemsCompleted,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                )
              : const ListComponent(homeTab: HomeTabEnum.completed),
        ),
      ],
    );
  }
}
