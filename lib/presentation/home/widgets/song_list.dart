import 'package:flune/common/helpers/is_dark_mode.dart';
import 'package:flune/core/configs/theme/app_colors.dart';
import 'package:flune/domain/entities/song/song.dart';
import 'package:flune/presentation/home/bloc/song_list_cubit.dart';
import 'package:flune/presentation/home/bloc/song_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../player/pages/player_screen.dart';

class SongList extends StatelessWidget {
  const SongList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SongListCubit()..getSongList(),
      child: SizedBox(
        child: BlocBuilder<SongListCubit, SongListState>(
          builder: (context, state) {
            if (state is SongListLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            }

            if (state is SongListLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Recent Releases',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        TextButton(
                          onPressed: (){},
                          child: Text(
                            'See All',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: Colors.green
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _songs(state.songs),
                  SizedBox(height: 50,)
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _songs(List<SongEntity> songs) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      shrinkWrap: true,
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PlayerScreen(
                      songEntity: song,
                    )
                )
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkMode ? AppColors.darkGrey : AppColors.lightGrey,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        song.coverUrl
                      )
                    )
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 40,
                    color: AppColors.greyDarker,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        song.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        song.artist,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                Text(
                  song.duration.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(width: 16),

                IconButton(
                  icon: Icon(
                    Icons.favorite_outline_outlined,
                    color: AppColors.greyDarker,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
