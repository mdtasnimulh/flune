import 'package:flune/domain/usecases/song/get_new_songs_use_case.dart';
import 'package:flune/domain/usecases/song/get_song_list_use_case.dart';
import 'package:flune/presentation/home/bloc/new_songs_state.dart';
import 'package:flune/presentation/home/bloc/song_list_state.dart';
import 'package:flune/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongListCubit extends Cubit<SongListState> {
  SongListCubit() : super(SongListLoading());

  Future<void> getSongList() async {
    var returnedSongList = await serviceLocator<GetSongListUseCase>().call();

    returnedSongList.fold(
        (error) => emit(SongListLoadFailure()),
        (data) => emit(SongListLoaded(songs: data))
    );
  }
}