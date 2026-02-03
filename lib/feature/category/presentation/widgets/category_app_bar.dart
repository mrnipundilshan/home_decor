import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? selectedCategory;
  const CategoryAppBar({super.key, this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    String displayTitle;
    
    if (selectedCategory != null && selectedCategory!.isNotEmpty) {
      displayTitle = context.translate(selectedCategory!);
    } else {
      displayTitle = context.translate("category");
    }
    
    return AppBar(
      title: Text(
        displayTitle,
        style: themeData.appBarTheme.titleTextStyle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
