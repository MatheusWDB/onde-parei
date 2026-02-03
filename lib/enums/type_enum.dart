enum TypeEnum {
  anime('Anime', 0),
  hq('HQ', 1),
  book('Livro', 2),
  manga('Mangá', 3),
  manhwa('Manhwa', 4),
  novel('Novela', 5),
  series('Série', 6);

  final String displayName;
  final int code;

  const TypeEnum(this.displayName, this.code);

  bool get isVideo => this == TypeEnum.anime || this == TypeEnum.series || this == TypeEnum.novel;
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
