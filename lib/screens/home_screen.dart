import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String _title() {
    return _activeMenu == 0 ? "Onde Parei?" : "Concluídos";
  }

  Widget _buildTap() {
    return _activeMenu == 0 ? DashboardTab() : CompletedTab();
  }

  void _changeMenu(int value) {
    HapticFeedback.selectionClick();

    setState(() {
      _activeMenu = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.all(8.0),
        actions: [
          IconButton(
            style: IconButton.styleFrom(elevation: 2.0),
            onPressed: () {
              HapticFeedback.selectionClick();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
            icon: Icon(Icons.settings_outlined),
          ),
        ],
        title: Text(
          _title(),
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activeMenu,
        onDestinationSelected: _changeMenu,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.archive_outlined),
            label: 'Concluídos',
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
                  shape: CircleBorder(),
                  onPressed: () {
                    HapticFeedback.selectionClick();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddOrUpdateWorkScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add, fontWeight: FontWeight.bold),
                ),
              ),
            )
          : null,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(child: _buildTap())],
          ),
        ),
      ),
    );
  }
}
