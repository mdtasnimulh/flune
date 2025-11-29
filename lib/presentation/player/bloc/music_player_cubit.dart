import 'package:flune/presentation/player/bloc/music_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerCubit extends Cubit<MusicPlayerState> {

  AudioPlayer audioPlayer = AudioPlayer();

  Duration musicDuration = Duration.zero;
  Duration musicPosition = Duration.zero;

  MusicPlayerCubit() : super(MusicPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      musicPosition = position;
      updateMusicPlayer();
    });

    audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        musicDuration = duration;
      }
      updateMusicPlayer(); // optional
    });
  }

  void updateMusicPlayer() {
    emit(
      MusicPlayerLoaded()
    );
  }

  Future<void> loadMusic(String musicUrl) async {
    try {
      await audioPlayer.setUrl(musicUrl);
      emit(MusicPlayerLoaded());
    } catch(e) {
      emit(MusicPlayerFailure());
    }
  }

  void playPauseMusic() {
    if (audioPlayer.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.play();
    }
    emit(MusicPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }

}