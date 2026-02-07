import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_colors.dart';

class CategoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? selectedCategory;
  final bool isShowingFavorites;
  final VoidCallback onToggleFavorites;

  const CategoryAppBar({
    super.key,
    this.selectedCategory,
    required this.isShowingFavorites,
    required this.onToggleFavorites,
  });

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
      title: Text(displayTitle, style: themeData.appBarTheme.titleTextStyle),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onToggleFavorites,
          icon: Icon(
            isShowingFavorites ? Icons.favorite : Icons.favorite_border,
          ),
          color: AppColors.commonPrimary,
        ),
        SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
