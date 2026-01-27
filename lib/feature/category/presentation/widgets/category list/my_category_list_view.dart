import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_view_card.dart';

class MyCategoryListView extends StatefulWidget {
  const MyCategoryListView({super.key});

  @override
  State<MyCategoryListView> createState() => _MyCategoryListViewState();
}

class _MyCategoryListViewState extends State<MyCategoryListView> {
  String selectedCategory = "all";

  void _onCategorySelected(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
      });
      print(selectedCategory);
    }
  }

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
              onTap: () => _onCategorySelected("all"),
            ),
            MyCarouselViewCard(
              title: context.translate('beds'),
              category: "beds",
              isSelected: selectedCategory == "beds",
              onTap: () => _onCategorySelected("beds"),
            ),
            MyCarouselViewCard(
              title: context.translate('sofa'),
              category: "sofa",
              isSelected: selectedCategory == "sofa",
              onTap: () => _onCategorySelected("sofa"),
            ),
            MyCarouselViewCard(
              title: context.translate('decor'),
              category: "decor",
              isSelected: selectedCategory == "decor",
              onTap: () => _onCategorySelected("decor"),
            ),
            MyCarouselViewCard(
              title: context.translate('chair'),
              category: "chair",
              isSelected: selectedCategory == "chair",
              onTap: () => _onCategorySelected("chair"),
            ),
            MyCarouselViewCard(
              title: context.translate('light'),
              category: "light",
              isSelected: selectedCategory == "light",
              onTap: () => _onCategorySelected("light"),
            ),
            MyCarouselViewCard(
              title: context.translate('table'),
              category: "table",
              isSelected: selectedCategory == "table",
              onTap: () => _onCategorySelected("table"),
            ),
          ],
        ),
      ),
    );
  }
}
