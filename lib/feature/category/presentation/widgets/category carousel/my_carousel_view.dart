import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20carousel/my_carousel_view_card.dart';

class MyCarouselView extends StatelessWidget {
  const MyCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: CarouselView(
        scrollDirection: .horizontal,
        itemExtent: AppSizes.screenWidth(context) * 0.22,

        children: [
          MyCarouselViewCard(title: context.translate('beds')),
          MyCarouselViewCard(title: context.translate('bathroom')),
          MyCarouselViewCard(title: context.translate('dinning')),
          MyCarouselViewCard(title: context.translate('kitchen')),
          MyCarouselViewCard(title: context.translate('living')),
          MyCarouselViewCard(title: context.translate('kitchen')),
          MyCarouselViewCard(title: context.translate('living')),
        ],
      ),
    );
  }
}
