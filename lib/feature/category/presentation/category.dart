import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/category/presentation/bloc/category_bloc.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_category_list_view.dart';
import 'package:home_decor/feature/category/presentation/widgets/category_app_bar.dart';
import 'package:home_decor/feature/category/presentation/widgets/Items/items.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_bloc.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_event.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String selectedCategory = "all";
  bool isShowingFavorites = false;

  void _onCategorySelected(String category) {
    if (selectedCategory != category) {
      setState(() {
        selectedCategory = category;
        isShowingFavorites = false;
      });
    }
  }

  void _toggleFavorites() {
    _onCategorySelected("all");

    setState(() {
      isShowingFavorites = !isShowingFavorites;
      if (isShowingFavorites) {
        context.read<FavoritesBloc>().add(LoadFavoritesEvent());
      } else {
        context.read<CategoryBloc>().add(CategoryInitialEvent(category: "all"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: CategoryAppBar(
        selectedCategory: selectedCategory,
        isShowingFavorites: isShowingFavorites,
        onToggleFavorites: _toggleFavorites,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: Stack(
          children: [
            // The scrollable content
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Items(isShowingFavorites: isShowingFavorites),
            ),
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
