import 'package:flune/common/widgets/button/basic_app_button.dart';
import 'package:flune/core/configs/assets/app_images.dart';
import 'package:flune/core/configs/assets/app_vectors.dart';
import 'package:flune/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../choose_mode/pages/choose_mode.dart';

class GetStatedPage extends StatelessWidget {
  const GetStatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 32
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.introBg
                )
              )
            ),
          ),

          Container(
            color: Colors.black.withValues(alpha: 0.15),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                      AppVectors.logo
                  ),
                ),
                Spacer(),
                Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                  ),
                ),
                SizedBox(height: 21),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 21),
                BasicAppButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const ChooseModePage()),
                    );
                  },
                  title: 'Get Started',
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
