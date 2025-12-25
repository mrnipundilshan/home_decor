import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      title: Row(
        children: [
          Image(
            image: AssetImage("assets/logo.png"),
            height: AppSizes.screenWidth(context) * 0.08,
          ),
          Text(" Decoz", style: AppCustomTextStyles.splashScreenText),
        ],
      ),
      actions: [
        Icon(Icons.search, color: themeData.colorScheme.inversePrimary),
        SizedBox(width: 5),
        Icon(
          Icons.favorite_border,
          color: themeData.colorScheme.inversePrimary,
        ),
        SizedBox(width: 15),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
