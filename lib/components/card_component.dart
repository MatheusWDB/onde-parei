import 'package:flutter/material.dart';
import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class CardComponent extends StatelessWidget {
  final Work work;
  final ValueChanged<Work> onUpdate;

  const CardComponent({super.key, required this.work, required this.onUpdate});

  void _increase() => onUpdate(work.increment());
  void _decrement() => onUpdate(work.decrement());

  @override
  Widget build(BuildContext context) {
    IconData? icon;

    if (work.isReadingType) {
      icon = Icons.menu_book_sharp;
    } else {
      icon = Icons.tv;
    }

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddOrUpdateWorkScreen(work: work),
        ),
      ),
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 8.0,
            children: [
              Icon(icon),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(work.title), Text(work.progressLabel)],
                ),
              ),
              work.isFinished
                  ? Row(
                      spacing: 8,
                      children: [Text('Conclúido'), Icon(Icons.verified)],
                    )
                  : Row(
                      spacing: 10.0,
                      children: [
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: work.isFinished ? null : _decrement,
                              child: const Icon(
                                Icons.remove,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          width: 35.0,
                          height: 35.0,
                          child: FittedBox(
                            child: FloatingActionButton(
                              //foregroundColor: Colors.white,
                              shape: CircleBorder(),
                              //backgroundColor: primaryColor,
                              onPressed: work.isFinished ? null : _increase,
                              child: const Icon(
                                Icons.add,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
