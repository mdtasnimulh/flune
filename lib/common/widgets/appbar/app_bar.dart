import 'package:flune/common/helpers/is_dark_mode.dart';
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
          )
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);


}
