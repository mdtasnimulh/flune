import 'package:dartz/dartz.dart';
import 'package:flune/core/usecase/usecase.dart';
import 'package:flune/data/repoimpl/song/song_repository_impl.dart';
import 'package:flune/domain/repository/song/song.dart';
import 'package:flune/service_locator.dart';

class GetSongListUseCase implements UseCase<Either,dynamic>{

  @override
  Future<Either> call({params}) async {
    return await serviceLocator<SongsRepository>().getSongList();
  }

}