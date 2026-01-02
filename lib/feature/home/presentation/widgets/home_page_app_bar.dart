import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

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
          Text(" ${context.translate('decoz')}", style: AppCustomTextStyles.splashScreenText),
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
        IconButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogOutButtonClickedEvent());
          },
          icon: Icon(Icons.logout_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
