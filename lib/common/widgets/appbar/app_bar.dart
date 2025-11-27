import 'package:flune/common/helpers/is_dark_mode.dart';
import 'package:flune/core/configs/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title;
  final bool hideBack;

  const BasicAppBar({
    this.title,
    this.hideBack = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: title ?? Text(''),
          leading: hideBack ? null : IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: context.isDarkMode ? Colors.white.withValues(
                        alpha: 0.03) : Colors.black.withValues(alpha: 0.04),
                    shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 24,
                ),
              )
          ),
        actions: [
          IconButton(
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
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}
