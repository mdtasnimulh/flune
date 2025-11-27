import 'package:flune/common/helpers/is_dark_mode.dart';
import 'package:flune/core/configs/theme/app_colors.dart';
import 'package:flune/domain/entities/song/song.dart';
import 'package:flune/presentation/home/bloc/new_songs_cubit.dart';
import 'package:flune/presentation/home/bloc/new_songs_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewSongs extends StatelessWidget {
  const NewSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NewSongsCubit()..getNewSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewSongsCubit, NewSongsState>(
          builder: (context, state) {
            if (state is NewSongsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is NewSongsLoaded) {
              return _songs(
                state.songs
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == songs.length - 1 ? 0 : 16,
            ),
            child: SizedBox(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(song.coverUrl),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          transform: Matrix4.translationValues(10, 10, 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            color: context.isDarkMode ? AppColors.greyLighter : AppColors.greyDarker,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    song.title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    song.artist,
                    style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
