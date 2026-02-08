import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';

class CartPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return AppBar(
      iconTheme: IconThemeData(color: themeData.colorScheme.inversePrimary),
      centerTitle: true,
      title: Text(
        context.translate('cart'),
        style: themeData.appBarTheme.titleTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
