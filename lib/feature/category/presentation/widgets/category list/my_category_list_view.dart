import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_view_card.dart';

class MyCarouselView extends StatelessWidget {
  const MyCarouselView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: .horizontal,
        child: Row(
          children: [
            MyCarouselViewCard(
              title: context.translate('all'),
              category: "all",
            ),
            MyCarouselViewCard(
              title: context.translate('beds'),
              category: "beds",
            ),
            MyCarouselViewCard(
              title: context.translate('sofa'),
              category: "sofa",
            ),
            MyCarouselViewCard(
              title: context.translate('decor'),
              category: "decor",
            ),
            MyCarouselViewCard(
              title: context.translate('chair'),
              category: "chair",
            ),
            MyCarouselViewCard(
              title: context.translate('light'),
              category: "light",
            ),
            MyCarouselViewCard(
              title: context.translate('table'),
              category: "table",
            ),
          ],
        ),
      ),
    );
  }
}
