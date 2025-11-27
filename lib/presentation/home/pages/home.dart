import 'package:flune/common/helpers/is_dark_mode.dart';
import 'package:flune/common/widgets/appbar/app_bar.dart';
import 'package:flune/core/configs/assets/app_images.dart';
import 'package:flune/core/configs/assets/app_vectors.dart';
import 'package:flune/core/configs/theme/app_colors.dart';
import 'package:flune/presentation/home/widgets/new_songs.dart';
import 'package:flune/presentation/home/widgets/song_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
              AppVectors.logo,
              height: 40,
              width: 40
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            SizedBox(height: 12,),
            _tabs(),
            SizedBox(height: 12,),
            SizedBox(
              height: 260,
              child: TabBarView(
                controller: _tabController,
                children: [
                  NewSongs(),
                  Container(),
                  Container(),
                  Container()
                ],
              ),
            ),
            SizedBox(height: 16,),
            SongList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard() {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                  AppVectors.homeTopCard
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                AppImages.homeArtist
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      indicatorColor: AppColors.primary,
      tabAlignment: TabAlignment.center,
      dividerColor: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16
      ),
      tabs: [
        const Text(
          'New',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
          ),
        ),
        const Text(
          'Videos',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        const Text(
          'Artist',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        ),
        const Text(
          'Podcasts',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16
          ),
        )
      ],
    );
  }
}
