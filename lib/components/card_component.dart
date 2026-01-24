import 'package:flutter/material.dart';
import 'package:onde_parei/models/work.dart';

class CardComponent extends StatelessWidget {
  final Work work;
  const CardComponent({super.key, required this.work});

  @override
  Widget build(BuildContext context) {
    String? subTitle;
    IconData? icon;
    if (work.isReadingType) {
      icon = Icons.menu_book_sharp;
      subTitle = "Cap. ${work.chapter} • Pág. ${work.page}";
    } else {
      icon = Icons.tv;
      subTitle = "Temp. ${work.season} • Ep. ${work.episode}";
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
                children: [Text(work.title), Text(subTitle)],
              ),
            ),
            work.isFinished
                ? Row(
                    spacing: 8,
                    children: [Text('Conclúido'), Icon(Icons.verified)],
                  )
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
