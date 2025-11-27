import '../../../domain/entities/song/song.dart';

abstract class SongListState {}

class SongListLoading extends SongListState {}

class SongListLoaded extends SongListState {
  final List<SongEntity> songs;

  SongListLoaded({required this.songs});
}

class SongListLoadFailure extends SongListState {}