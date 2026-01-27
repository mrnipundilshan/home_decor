import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyCarouselViewCard extends StatefulWidget {
  final String title;
  final String category;

  const MyCarouselViewCard({
    super.key,
    required this.title,
    required this.category,
  });

  @override
  State<MyCarouselViewCard> createState() => _MyCarouselViewCardState();
}

class _MyCarouselViewCardState extends State<MyCarouselViewCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: SizedBox(
        width: AppSizes.screenWidth(context) * 0.22,
        height: 45,

        child: ElevatedButton(
          onPressed: () {
            setState(() {
              isSelected = !isSelected;
            });
          },

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
            widget.title,
            style: themeData.textTheme.headlineSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
