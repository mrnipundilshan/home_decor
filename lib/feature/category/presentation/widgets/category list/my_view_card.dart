import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyCarouselViewCard extends StatelessWidget {
  final String title;
  final String category;
  final bool isSelected;
  final VoidCallback onTap;

  const MyCarouselViewCard({
    super.key,
    required this.title,
    required this.category,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: SizedBox(
        width: AppSizes.screenWidth(context) * 0.22,
        height: 45,

        child: ElevatedButton(
          onPressed: onTap,

          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected
                ? AppColors.commonPrimary
                : Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: isSelected
                  ? BorderSide()
                  : BorderSide(color: themeData.colorScheme.inversePrimary),
            ),
            elevation: 0, // match flat Container look (optional)
          ),
          child: Text(
            title,
            style: themeData.textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
