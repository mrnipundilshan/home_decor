import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

class ProfilePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProfilePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      actions: [
        Icon(Icons.edit_outlined),
        SizedBox(width: 15),

        IconButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogOutButtonClickedEvent());
          },
          icon: Icon(Icons.logout_outlined),
        ),
      ],
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
