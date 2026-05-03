import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/providers/loading_state_provider.dart';
import 'package:onde_parei/providers/work_list_provider.dart';
import 'package:onde_parei/screens/settings_screen.dart';
import 'package:onde_parei/screens/work_form_screen.dart';
import 'package:onde_parei/tabs/completed_tab.dart';
import 'package:onde_parei/tabs/dashboard_tab.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _activeMenu = 0;

  String _title(AppLocalizations t) =>
      _activeMenu == 0 ? t.whereDidIStop : t.itemsCompleted;

  void _changeMenu(int value) {
    HapticFeedback.selectionClick();
    ref.read(workListProvider.notifier).refresh();
    setState(() {
      _activeMenu = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final loading = ref.watch(loadingStateProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            actionsPadding: const EdgeInsets.all(8.0),
            actions: [
              IconButton(
                style: IconButton.styleFrom(elevation: 2.0),
                onPressed: () {
                  HapticFeedback.selectionClick();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
                  ).then((_) => ref.read(workListProvider.notifier).refresh());
                },
                icon: const Icon(LucideIcons.settings),
              ),
            ],
            title: Text(
              _title(t),
              key: ValueKey(_activeMenu),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _activeMenu,
            onDestinationSelected: _changeMenu,
            destinations: [
              NavigationDestination(
                icon: const Icon(LucideIcons.layoutGrid),
                label: t.appHome,
              ),
              NavigationDestination(
                icon: const Icon(LucideIcons.archive),
                label: t.itemsCompleted,
              ),
            ],
          ),
          floatingActionButton: _activeMenu == 0
              ? Container(
                  alignment: Alignment.bottomRight,
                  width: 45.0,
                  height: 45.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        HapticFeedback.selectionClick();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WorkFormScreen(),
                          ),
                        ).then(
                          (_) => ref.read(workListProvider.notifier).refresh(),
                        );
                      },
                      child: const Icon(
                        LucideIcons.plus,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : null,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: IndexedStack(
                index: _activeMenu,
                children: const [DashboardTab(), CompletedTab()],
              ),
            ),
          ),
        ),
        if (loading) ...[
          const ModalBarrier(dismissible: false, color: Colors.black45),
          const Center(child: CircularProgressIndicator()),
        ],
      ],
    );
  }
}
