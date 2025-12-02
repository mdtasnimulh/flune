import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flune/domain/entities/song/song.dart';

class SongModel {
  String ? title;
  String ? artist;
  String ? coverUrl;
  num ? duration;
  Timestamp ? releaseDate;
  String ? musicUrl;

  SongModel({
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.duration,
    required this.releaseDate,
    required this.musicUrl,
  });

  SongModel.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    coverUrl = data['cover_url'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    musicUrl = data['musicUrl'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        title: title ?? "",
        artist: artist ?? "",
        coverUrl: coverUrl ?? "",
        duration: duration ?? 0,
        releaseDate: releaseDate!,
        musicUrl: musicUrl ?? "",
    );
  }
}