import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/category/presentation/widgets/category%20list/my_category_list_view.dart';
import 'package:home_decor/feature/category/presentation/widgets/home_page_app_bar.dart';
import 'package:home_decor/feature/category/presentation/widgets/top%20selling/items.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthonticatedState) {
          context.go('/signin');
        }
      },
      child: Scaffold(
        backgroundColor: themeData.canvasColor,
        appBar: CategoryAppBar(),
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
                child: TopSelling(),
              ),
              // The pinned carousel
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: MyCategoryListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
