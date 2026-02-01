import 'dart:convert';

import 'package:onde_parei/enums/type_enum.dart';

class Work {
  final int? id;
  final String title;
  final TypeEnum type;
  final int season;
  final int episode;
  final double chapter;
  final int page;
  final bool isFinished;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Work({
    this.id,
    required this.title,
    required this.type,
    this.season = 1,
    this.episode = 1,
    this.chapter = 1.0,
    this.page = 1,
    this.isFinished = false,
    this.createdAt,
    this.updatedAt,
  });

  bool get isReadingType => type.isReading;

  Work increment() {
    if (isReadingType) {
      if (type == TypeEnum.manhwa) {
        return copyWith(chapter: chapter + 0.5);
      }
      if (type == TypeEnum.manga || type == TypeEnum.hq) {
        return copyWith(chapter: chapter + 1.0);
      }
      return copyWith(page: page + 1);
    }
    return copyWith(episode: episode + 1);
  }

  Work decrement() {
    if (isReadingType) {
      if (type == TypeEnum.manhwa) {
        return copyWith(chapter: _clampDouble(chapter - 0.5));
      }
      if (type == TypeEnum.manga || type == TypeEnum.hq) {
        return copyWith(chapter: _clampDouble(chapter - 1.0));
      }
      return copyWith(page: _clampInt(page - 1));
    }
    return copyWith(episode: _clampInt(episode - 1));
  }

  String get progressLabel {
    if (isReadingType) {
      final chapterLabel = type == TypeEnum.manhwa
          ? chapter.toStringAsFixed(1)
          : chapter.toStringAsFixed(0);

      return "Cap. $chapterLabel${type == TypeEnum.book ? " • Pág. $page" : ""}";
    }
    return "Temp. $season • Ep. $episode";
  }

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'title': title,
      'type': type.code,
      'season': season,
      'episode': episode,
      'chapter': chapter,
      'page': page,
      'isFinished': isFinished ? 1 : 0,
      'createdAt': (createdAt ?? DateTime.now()).toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };

    if (id == null) {
      map.remove('id');
    }

    return map;
  }

  factory Work.fromMap(Map<String, dynamic> map) {
    return Work(
      id: map['id'] as int?,
      title: map['title'] as String? ?? 'Sem título',
      type: map['type'] is int?
          ? TypeEnum.fromCode(map['type'])
          : TypeEnum.fromName(map['type'].toString()),
      season: map['season'] as int? ?? 0,
      episode: map['episode'] as int? ?? 0,
      chapter: (map['chapter'] ?? 0).toDouble(),
      page: map['page'] as int? ?? 0,
      isFinished: map['isFinished'] == 1 || map['isFinished'] == true,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : null,
    );
  }

  String toJson() {
    final map = toMap();
    map['type'] = type.name;
    return json.encode(map);
  }

  factory Work.fromJson(String source) => Work.fromMap(json.decode(source));

  Work copyWith({
    int? id,
    String? title,
    TypeEnum? type,
    int? season,
    int? episode,
    double? chapter,
    int? page,
    bool? isFinished,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Work(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      season: season ?? this.season,
      episode: episode ?? this.episode,
      chapter: chapter ?? this.chapter,
      page: page ?? this.page,
      isFinished: isFinished ?? this.isFinished,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  int _clampInt(int value) => value < 0 ? 0 : value;
  double _clampDouble(double value) => value < 0 ? 0 : value;

  @override
  String toString() {
    return 'Work(id: $id, title: $title, type: ${type.displayName}, season: $season, episode: $episode, chapter: $chapter, page: $page, isFinished: $isFinished, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
