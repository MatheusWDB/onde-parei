// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:onde_parei/enums/type_enum.dart';
import 'package:onde_parei/l10n/app_localizations.dart';

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
    required this.title,
    required this.type,
    this.id,
    this.season = 1,
    this.episode = 1,
    this.chapter = 1.0,
    this.page = 1,
    this.isFinished = false,
    this.createdAt,
    this.updatedAt,
  });

  bool get isReading => type.isReading;

  Work increment() {
    if (isReading) {
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
    if (isReading) {
      if (type == TypeEnum.manhwa) {
        return copyWith(chapter: (chapter - 0.5).clamp(0.0, double.maxFinite));
      }
      if (type == TypeEnum.manga || type == TypeEnum.hq) {
        return copyWith(chapter: (chapter - 1.0).clamp(0.0, double.maxFinite));
      }
      return copyWith(page: (page - 1).clamp(0, 999999));
    }
    return copyWith(episode: (episode - 1).clamp(0, 999999));
  }

  String progressLabel(AppLocalizations t) {
    if (isReading) {
      final chapterLabel = type == TypeEnum.manhwa
          ? chapter.toStringAsFixed(1)
          : chapter.toStringAsFixed(0);

      return type == TypeEnum.book
          ? t.progressReadingWithPage(chapterLabel, page)
          : t.progressReadingSimple(chapterLabel);
    }
    return t.progressWatching(season, episode);
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

  factory Work.fromMap(Map<String, dynamic> map) => Work(
    id: map['id'] as int?,
    title: map['title'] as String? ?? '',
    type: map['type'] is int?
        ? TypeEnum.fromCode(map['type'])
        : TypeEnum.fromName(map['type'].toString()),
    season: map['season'] as int? ?? 0,
    episode: map['episode'] as int? ?? 0,
    chapter: (map['chapter'] as num?)?.toDouble() ?? 0,
    page: map['page'] as int? ?? 0,
    isFinished: map['isFinished'] == 1 || map['isFinished'] == true,
    createdAt: map['createdAt'] != null
        ? DateTime.parse(map['createdAt'])
        : null,
    updatedAt: map['updatedAt'] != null
        ? DateTime.parse(map['updatedAt'])
        : null,
  );

  String toJson() {
    final map = toMap();
    map['type'] = type.name;
    return json.encode(map);
  }

  factory Work.fromJson(String source) =>
      Work.fromMap(json.decode(source) as Map<String, dynamic>);

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
  }) => Work(
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

  @override
  String toString() =>
      'Work(id: $id, title: $title, type: ${type.name}, season: $season, episode: $episode, chapter: $chapter, page: $page, isFinished: $isFinished, createdAt: $createdAt, updatedAt: $updatedAt)';

  @override
  bool operator ==(covariant Work other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.type == type &&
        other.season == season &&
        other.episode == episode &&
        other.chapter == chapter &&
        other.page == page &&
        other.isFinished == isFinished &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      type.hashCode ^
      season.hashCode ^
      episode.hashCode ^
      chapter.hashCode ^
      page.hashCode ^
      isFinished.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
