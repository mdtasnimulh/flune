import 'package:flune/domain/usecases/song/get_new_songs_use_case.dart';
import 'package:flune/presentation/home/bloc/new_songs_state.dart';
import 'package:flune/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSongsCubit extends Cubit<NewSongsState> {
  NewSongsCubit() : super(NewSongsLoading());

  Future<void> getNewSongs() async {
    var returnedSongs = await serviceLocator<GetNewSongsUseCase>().call();

    returnedSongs.fold(
        (error) => emit(NewSongsLoadFailure()),
        (data) => emit(NewSongsLoaded(songs: data))
    );
  }
}