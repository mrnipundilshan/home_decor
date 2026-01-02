import 'package:flutter/material.dart';

class ProfilePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfilePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      centerTitle: true,
      title: Text("Profile", style: themeData.appBarTheme.titleTextStyle),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
