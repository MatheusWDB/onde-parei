import 'package:flutter/material.dart';
import 'package:onde_parei/models/work.dart';

class ListComponent extends StatelessWidget {
  final Work mock;
  const ListComponent({super.key, required this.mock});

  @override
  Widget build(BuildContext context) {
    String? subTitle;
    IconData? icon;
    if (mock.isReadingType) {
      icon = Icons.menu_book_sharp;
      subTitle = "Cap. ${mock.chapter} • Pág. ${mock.page}";
    } else {
      icon = Icons.tv;
      subTitle = "Temp. ${mock.season} • Ep. ${mock.episode}";
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          spacing: 8.0,
          children: [
            Icon(icon),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(mock.title), Text(subTitle)],
              ),
            ),
            mock.isFinished
                ? Text('Conclúido')
                : Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: () {},
                              child: const Icon(
                                Icons.remove,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: () {},
                              child: const Icon(
                                Icons.add,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
