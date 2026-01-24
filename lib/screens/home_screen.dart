import 'package:flutter/material.dart';
import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/settings_screen.dart';
import 'package:onde_parei/tabs/archived_tab.dart';
import 'package:onde_parei/tabs/dashboard_tab.dart';

final List<Work> ondePareiMock = [
  Work(
    id: 1,
    title: 'One Piece',
    type: TypeEnum.anime,
    season: 1,
    episode: 1080,
  ),
  Work(
    id: 2,
    title: 'O Senhor dos Anéis',
    type: TypeEnum.book,
    chapter: 12,
    page: 245,
  ),
  Work(id: 3, title: 'The Bear', type: TypeEnum.series, season: 2, episode: 4),
  Work(id: 4, title: 'Batman: Ano Um', type: TypeEnum.hq, chapter: 2, page: 48),
  Work(id: 5, title: 'Berserk', type: TypeEnum.manga, chapter: 372, page: 12),
  Work(
    id: 6,
    title: 'It: Welcome to Derry',
    type: TypeEnum.series,
    season: 1,
    episode: 8,
    isFinished: true,
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _activeMenu = 0;
  String _title = "Onde Parei?";
  Widget _childContent = DashboardTab(ondePareiMock: ondePareiMock);

  void _changeMenu(int value) {
    setState(() {
      _activeMenu = value;
      _tabController.index = value;

      switch (value) {
        case 0:
          _childContent = DashboardTab(ondePareiMock: ondePareiMock);
          _title = 'Onde Parei?';
          break;
        default:
          _childContent = ArchivedTab(ondePareiMock: ondePareiMock);
          _title = 'Arquivados';
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        shadowColor: Colors.black,
        actionsPadding: EdgeInsets.all(8.0),
        actions: [
          IconButton(
            //color: Colors.white,
            style: IconButton.styleFrom(
              //backgroundColor: primaryColor,
              elevation: 2.0,
              //shadowColor: Colors.black,
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            ),
            icon: Icon(Icons.settings),
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(_title, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 2.0,
        shadowColor: Colors.black,
        child: TabBar(
          controller: _tabController,
          tabAlignment: TabAlignment.fill,
          //labelColor: primaryColor,
          //indicatorColor: primaryColor,
          onTap: (value) {
            if (value == _activeMenu) return;

            _changeMenu(value);
          },
          tabs: [
            Column(children: [Icon(Icons.grid_view), Text("Início")]),
            Column(children: [Icon(Icons.archive), Text("Arquivos")]),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Expanded(child: _childContent)],
          ),
        ),
      ),
    );
  }
}
