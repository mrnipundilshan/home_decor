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
              category: "sofas",
              isSelected: selectedCategory == "sofas",
              onTap: () {
                if (selectedCategory != "sofas") {
                  onCategorySelected("sofas");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "sofas"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('decors'),
              category: "decors",
              isSelected: selectedCategory == "decors",
              onTap: () {
                if (selectedCategory != "decors") {
                  onCategorySelected("decors");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "decors"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('chairs'),
              category: "chairs",
              isSelected: selectedCategory == "chairs",
              onTap: () {
                if (selectedCategory != "chairs") {
                  onCategorySelected("chairs");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "chairs"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('lights'),
              category: "lights",
              isSelected: selectedCategory == "lights",
              onTap: () {
                if (selectedCategory != "lights") {
                  onCategorySelected("lights");
                  BlocProvider.of<CategoryBloc>(
                    context,
                  ).add(CategoryInitialEvent(category: "lights"));
                }
              },
            ),

            MyCarouselViewCard(
              title: context.translate('tables'),
              category: "tables",
              isSelected: selectedCategory == "tables",
              onTap: () {
                if (selectedCategory != "tables") {
                  onCategorySelected("tables");
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
