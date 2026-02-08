import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyCarouselViewCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const MyCarouselViewCard({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      width: AppSizes.screenWidth(context) * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 3.0),
      decoration: BoxDecoration(color: themeData.canvasColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imageUrl, semanticsLabel: 'Catagory', height: 25),
          Text(
            title,
            style: themeData.textTheme.bodySmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
