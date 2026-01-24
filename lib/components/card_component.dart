import 'package:flutter/material.dart';
import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/models/work.dart';
import 'package:onde_parei/screens/add_or_update_work_screen.dart';

class CardComponent extends StatelessWidget {
  final Work work;
  final Function(Work) onUpdate;

  const CardComponent({super.key, required this.work, required this.onUpdate});

  void _increase() {
    late Work newWork;

    if (work.isReadingType) {
      if (work.type == TypeEnum.hq ||
          work.type == TypeEnum.manga ||
          work.type == TypeEnum.manhwa) {
        double increment = (work.type == TypeEnum.manhwa) ? 0.5 : 1.0;
        newWork = work.copyWith(chapter: work.chapter + increment);
      } else {
        newWork = work.copyWith(page: work.page + 1);
      }
    } else {
      newWork = work.copyWith(episode: work.episode + 1);
    }

    onUpdate(newWork);
  }

  void _decrement() {
    late Work newWork;

    if (work.isReadingType) {
      if (work.type == TypeEnum.hq ||
          work.type == TypeEnum.manga ||
          work.type == TypeEnum.manhwa) {
        double increment = (work.type == TypeEnum.manhwa) ? 0.5 : 1.0;
        newWork = work.copyWith(chapter: work.chapter - increment);
      } else {
        newWork = work.copyWith(page: work.page - 1);
      }
    } else {
      newWork = work.copyWith(episode: work.episode - 1);
    }

    onUpdate(newWork);
  }

  @override
  Widget build(BuildContext context) {
    String? subTitle;
    IconData? icon;
    if (work.isReadingType) {
      icon = Icons.menu_book_sharp;
      subTitle =
          "Cap. ${work.type == TypeEnum.manhwa ? work.chapter.toStringAsFixed(1) : work.chapter.toStringAsFixed(0)} • Pág. ${work.page}";
    } else {
      icon = Icons.tv;
      subTitle = "Temp. ${work.season} • Ep. ${work.episode}";
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
                  children: [Text(work.title), Text(subTitle)],
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
                              onPressed: _decrement,
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
                              onPressed: _increase,
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
