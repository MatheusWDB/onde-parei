import 'package:onde_parei/l10n/app_localizations.dart';

enum TypeEnum {
  anime(0),
  hq(1),
  book(2),
  manga(3),
  manhwa(4),
  novel(5),
  series(6);

  String displayName(AppLocalizations t) {
    switch (this) {
      case TypeEnum.anime:
        return t.typeAnime;
      case TypeEnum.hq:
        return t.typeHq;
      case TypeEnum.book:
        return t.typeBook;
      case TypeEnum.manga:
        return t.typeManga;
      case TypeEnum.manhwa:
        return t.typeManhwa;
      case TypeEnum.novel:
        return t.typeNovel;
      case TypeEnum.series:
        return t.typeSeries;
    }
  }

  final int code;

  const TypeEnum(this.code);

  bool get isVideo =>
      this == TypeEnum.anime ||
      this == TypeEnum.series ||
      this == TypeEnum.novel;
  bool get isReading => !isVideo;

  static TypeEnum fromCode(int code) => TypeEnum.values.firstWhere(
    (e) => e.code == code,
    orElse: () => TypeEnum.series,
  );

  static TypeEnum fromName(String name) => TypeEnum.values.firstWhere(
    (e) => e.name == name,
    orElse: () => TypeEnum.series,
  );

  @override
  String toString() => name;
}
