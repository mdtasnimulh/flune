import 'package:flune/common/widgets/appbar/app_bar.dart';
import 'package:flune/core/configs/constants/app_urls.dart';
import 'package:flune/presentation/player/bloc/music_player_cubit.dart';
import 'package:flune/presentation/player/bloc/music_player_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/configs/theme/app_colors.dart';
import '../../../domain/entities/song/song.dart';

class PlayerScreen extends StatelessWidget {
  final SongEntity songEntity;
  const PlayerScreen({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Now Playing',
          style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500
          ),
        ),
        action: IconButton(
          onPressed: () {

          },
          icon: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle
            ),
            child: Icon(
              Icons.more_vert,
              size: 24,
              color: AppColors.darkGrey,
            ),
          )
        ),
      ),
      
      body: BlocProvider(
        create: (_) => MusicPlayerCubit()..loadMusic(
          songEntity.musicUrl
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              _musicCover(context),
              SizedBox(height: 16,),
              _musicDescription(context),
              SizedBox(height: 24,),
              _musicPlayer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _musicCover(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            songEntity.coverUrl
          )
        )
      ),
    );
  }

  Widget _musicDescription(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          icon: Icon(
            Icons.favorite_outline_outlined,
            size: 32,
            color: AppColors.greyDarker,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _musicPlayer(BuildContext context) {
    return BlocBuilder<MusicPlayerCubit, MusicPlayerState>(
      builder: (context, state) {
        if (state is MusicPlayerLoading) {
          return CircularProgressIndicator();
        }
        if (state is MusicPlayerLoaded) {
          return Column(
            children: [
              Slider(
                value: context.read<MusicPlayerCubit>().musicPosition.inSeconds.toDouble().clamp(0, context.read<MusicPlayerCubit>().musicDuration.inSeconds.toDouble()),
                min: 0.0,
                max: context.read<MusicPlayerCubit>().musicDuration.inSeconds.toDouble() > 0 ? context.read<MusicPlayerCubit>().musicDuration.inSeconds.toDouble() : 1.0,
                onChanged: (value) {
                  final position = Duration(seconds: value.toInt());
                  context.read<MusicPlayerCubit>().audioPlayer.seek(position);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<MusicPlayerCubit>().musicPosition
                    )
                  ),
                  Text(
                    formatDuration(
                      context.read<MusicPlayerCubit>().musicDuration
                    )
                  )
                ],
              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: () {
                  context.read<MusicPlayerCubit>().playPauseMusic();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary
                  ),
                  child: Icon(
                    context.read<MusicPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow_rounded
                  ),
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
