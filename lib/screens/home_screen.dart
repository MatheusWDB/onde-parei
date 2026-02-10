import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:onde_parei/l10n/app_localizations.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';
import 'package:onde_parei/screens/settings_screen.dart';
import 'package:onde_parei/tabs/completed_tab.dart';
import 'package:onde_parei/tabs/dashboard_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeMenu = 0;

  String _title(AppLocalizations t) => _activeMenu == 0 ? t.whereDidIStop : t.itemsCompleted;

  Widget _buildTap() =>
      _activeMenu == 0 ? const DashboardTab() : const CompletedTab();

  void _changeMenu(int value) {
    HapticFeedback.selectionClick();

    setState(() {
      _activeMenu = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final Locale myLocale = Localizations.localeOf(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        actionsPadding: const EdgeInsets.all(8.0),
        actions: [
          IconButton(
            style: IconButton.styleFrom(elevation: 2.0),
            onPressed: () {
              HapticFeedback.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
            icon: const Icon(LucideIcons.settings),
          ),
        ],
        title: Text(
          _title(t),
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
                        builder: (context) => const AddOrUpdateWorkScreen(),
                      ),
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
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(child: _buildTap())],
          ),
        ),
      ),
    );
  }
}
