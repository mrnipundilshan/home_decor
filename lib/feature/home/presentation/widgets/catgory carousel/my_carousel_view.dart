import 'package:flutter/material.dart';
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
            imageUrl: "assets/catagory/bedroom.svg",
            title: "Bedroom",
          ),

          MyCarouselViewCard(
            imageUrl: "assets/catagory/bath.svg",
            title: "Bathroom",
          ),
          MyCarouselViewCard(
            imageUrl: "assets/catagory/Dinning.svg",
            title: "Dinning",
          ),
          MyCarouselViewCard(
            imageUrl: "assets/catagory/kitchen.svg",
            title: "Kitchen",
          ),
          MyCarouselViewCard(
            imageUrl: "assets/catagory/living.svg",
            title: "Living",
          ),
          MyCarouselViewCard(
            imageUrl: "assets/catagory/kitchen.svg",
            title: "Test",
          ),
          MyCarouselViewCard(
            imageUrl: "assets/catagory/living.svg",
            title: "Test",
          ),
        ],
      ),
    );
  }
}
