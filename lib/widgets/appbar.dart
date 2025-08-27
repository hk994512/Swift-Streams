import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '/helper/ui_helper.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
    this.title, {
    super.key,
    this.leading,
    this.actions,
    this.appSize = 50,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final double appSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      centerTitle: true,
      toolbarHeight: 50,
      title: UIHelper.text(
        title,
        fontSize: 20,
        color: AppColors.white,
        fontWeight: FontWeight.w700,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appSize);
}
