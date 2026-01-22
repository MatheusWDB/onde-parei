import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  int _activeMenu = 0;
  String _title = "Onde Parei";
  Widget _childContent = Column();

  void _changeMenu(int value) {
    setState(() {
      _activeMenu = value;
      _tabController.index = value;

      switch (value) {
        case 0:
          _childContent = Column();
          _title = 'Onde Parei';
          break;
        default:
          _childContent = Column();
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
            onPressed: () {
              int value = _activeMenu == 0 ? 1 : 0;
              _changeMenu(value);
            },
            icon: Icon(_activeMenu == 0 ? Icons.archive : Icons.grid_view),
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
      floatingActionButton: _activeMenu == 0
          ? Container(
              alignment: Alignment.bottomRight,
              width: 45.0,
              height: 45.0,
              child: FittedBox(
                child: FloatingActionButton(
                  //foregroundColor: Colors.white,
                  shape: CircleBorder(),
                  //backgroundColor: primaryColor,
                  onPressed: () {},
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
            children: [Expanded(child: _childContent)],
          ),
        ),
      ),
    );
  }
}
