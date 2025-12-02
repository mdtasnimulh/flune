import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String title;
  final String artist;
  final String coverUrl;
  final num duration;
  final Timestamp releaseDate;
  final String musicUrl;

  SongEntity({
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.duration,
    required this.releaseDate,
    required this.musicUrl
  });
}
