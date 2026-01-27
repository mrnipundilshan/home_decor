import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_view_card.dart';

class MyCategoryListView extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const MyCategoryListView({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

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
              isSelected: selectedCategory == "all",
              onTap: () => onCategorySelected("all"),
            ),
            MyCarouselViewCard(
              title: context.translate('beds'),
              category: "beds",
              isSelected: selectedCategory == "beds",
              onTap: () => onCategorySelected("beds"),
            ),
            MyCarouselViewCard(
              title: context.translate('sofa'),
              category: "sofa",
              isSelected: selectedCategory == "sofa",
              onTap: () => onCategorySelected("sofa"),
            ),
            MyCarouselViewCard(
              title: context.translate('decor'),
              category: "decor",
              isSelected: selectedCategory == "decor",
              onTap: () => onCategorySelected("decor"),
            ),
            MyCarouselViewCard(
              title: context.translate('chair'),
              category: "chair",
              isSelected: selectedCategory == "chair",
              onTap: () => onCategorySelected("chair"),
            ),
            MyCarouselViewCard(
              title: context.translate('light'),
              category: "light",
              isSelected: selectedCategory == "light",
              onTap: () => onCategorySelected("light"),
            ),
            MyCarouselViewCard(
              title: context.translate('table'),
              category: "table",
              isSelected: selectedCategory == "table",
              onTap: () => onCategorySelected("table"),
            ),
          ],
        ),
      ),
    );
  }
}
