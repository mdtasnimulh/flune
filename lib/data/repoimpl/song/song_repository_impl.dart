import 'package:dartz/dartz.dart';
import 'package:flune/data/sources/song/song_firebase_service.dart';
import 'package:flune/domain/repository/song/song.dart';
import 'package:flune/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {

  @override
  Future<Either> getNewSongs() async {
    return await serviceLocator<SongFirebaseService>().getNewSongs();
  }

}