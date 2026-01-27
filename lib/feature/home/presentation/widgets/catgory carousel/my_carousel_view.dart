import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/home/presentation/widgets/catgory%20carousel/my_carousel_view_card.dart';

class MyCarouselView extends StatelessWidget {
  const MyCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SizedBox(
      height: 100,
      child: CarouselView(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: themeData.colorScheme.inversePrimary),
          borderRadius: BorderRadius.circular(15),
        ),
        scrollDirection: .horizontal,
        itemExtent: AppSizes.screenWidth(context) * 0.2,
        children: [
          MyCarouselViewCard(
            imageUrl: "assets/category/bedroom.svg",
            title: context.translate('bedroom'),
          ),

          MyCarouselViewCard(
            imageUrl: "assets/category/bath.svg",
            title: context.translate('bathroom'),
          ),
          MyCarouselViewCard(
            imageUrl: "assets/category/Dinning.svg",
            title: context.translate('dinning'),
          ),
          MyCarouselViewCard(
            imageUrl: "assets/category/kitchen.svg",
            title: context.translate('kitchen'),
          ),
          MyCarouselViewCard(
            imageUrl: "assets/category/living.svg",
            title: context.translate('living'),
          ),
          MyCarouselViewCard(
            imageUrl: "assets/category/kitchen.svg",
            title: context.translate('kitchen'),
          ),
          MyCarouselViewCard(
            imageUrl: "assets/category/living.svg",
            title: context.translate('living'),
          ),
        ],
      ),
    );
  }
}
