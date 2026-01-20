import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';

class ProfilePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfilePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      actions: [Icon(Icons.edit_outlined), SizedBox(width: 15)],
      centerTitle: true,
      title: Text(
        context.translate('profile'),
        style: themeData.appBarTheme.titleTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
