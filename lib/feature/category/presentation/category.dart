import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_category_list_view.dart';
import 'package:home_decor/feature/category/presentation/widgets/home_page_app_bar.dart';
import 'package:home_decor/feature/category/presentation/widgets/Items/items.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String selectedCategory = "all";

  void _onCategorySelected(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: CategoryAppBar(selectedCategory: selectedCategory),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: Stack(
          children: [
            // The scrollable content
            Padding(padding: const EdgeInsets.only(top: 80), child: Items()),
            // The pinned carousel
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: MyCategoryListView(
                selectedCategory: selectedCategory,
                onCategorySelected: _onCategorySelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
