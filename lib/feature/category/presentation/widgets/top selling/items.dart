import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/bloc/category_bloc.dart';
import 'package:home_decor/feature/category/presentation/widgets/top%20selling/item_card.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';
import 'package:shimmer/shimmer.dart';

class TopSelling extends StatefulWidget {
  const TopSelling({super.key});

  @override
  State<TopSelling> createState() => _TopSellingState();
}

class _TopSellingState extends State<TopSelling> {
  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return Shimmer.fromColors(
              baseColor: themeData.colorScheme.inversePrimary,
              highlightColor: themeData.colorScheme.primary,
              enabled: true,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 300,
                ),
                physics: BouncingScrollPhysics(),
                scrollDirection: .vertical,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ItemCard(
                    title: "",
                    subtitle: "",
                    imageUrl: "",
                    price: 0,
                    rating: 0,
                  );
                },
              ),
            );
          }
          if (state is CategoryLoadedState) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 300,
              ),
              physics: BouncingScrollPhysics(),
              scrollDirection: .vertical,
              itemCount: state.topSellingItems.length,
              itemBuilder: (context, index) {
                final topSellingItem = state.topSellingItems[index];
                return ItemCard(
                  title: topSellingItem.title,
                  subtitle: topSellingItem.subtitle,
                  imageUrl: topSellingItem.imageUrl,
                  price: topSellingItem.price,
                  rating: topSellingItem.rating,
                );
              },
            );
          }

          if (state is CategoryErrorState) {
            return Center(
              child: Text(
                context.translate('error_state'),
                style: themeData.textTheme.labelLarge,
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
