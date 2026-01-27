import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';

class MyCarouselViewCard extends StatelessWidget {
  final String title;

  const MyCarouselViewCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(
        color: AppColors.commonPrimary,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: themeData.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
