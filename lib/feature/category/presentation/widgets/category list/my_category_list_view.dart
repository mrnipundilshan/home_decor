import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/bloc/category_bloc.dart';
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
              onTap: () {
                if (selectedCategory != "all") {
                  onCategorySelected("all");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "all"));
                }
              },
            ),
            MyCarouselViewCard(
              title: context.translate('beds'),
              category: "beds",
              isSelected: selectedCategory == "beds",
              onTap: () {
                if (selectedCategory != "beds") {
                  onCategorySelected("beds");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "beds"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('sofa'),
              category: "sofa",
              isSelected: selectedCategory == "sofa",
              onTap: () {
                if (selectedCategory != "sofa") {
                  onCategorySelected("sofa");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "sofas"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('decor'),
              category: "decor",
              isSelected: selectedCategory == "decor",
              onTap: () {
                if (selectedCategory != "decor") {
                  onCategorySelected("decor");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "decors"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('chair'),
              category: "chair",
              isSelected: selectedCategory == "chair",
              onTap: () {
                if (selectedCategory != "chair") {
                  onCategorySelected("chair");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "chairs"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('light'),
              category: "light",
              isSelected: selectedCategory == "light",
              onTap: () {
                if (selectedCategory != "light") {
                  onCategorySelected("light");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "lights"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('table'),
              category: "table",
              isSelected: selectedCategory == "table",
              onTap: () {
                if (selectedCategory != "table") {
                  onCategorySelected("table");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "tables"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
