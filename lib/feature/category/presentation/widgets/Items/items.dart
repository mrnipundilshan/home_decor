import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/feature/category/presentation/bloc/category_bloc.dart';
import 'package:home_decor/feature/category/presentation/widgets/Items/item_card.dart';
import 'package:shimmer/shimmer.dart';

class Items extends StatefulWidget {
  const Items({super.key});

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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
              itemCount: state.itemList.length,
              itemBuilder: (context, index) {
                final topSellingItem = state.itemList[index];
                return ItemCard(
                  title: topSellingItem.title ?? '',
                  subtitle: topSellingItem.subtitle ?? '',
                  imageUrl: topSellingItem.imageUrl ?? '',
                  price: topSellingItem.price ?? 0,
                  rating: topSellingItem.rating ?? 0,
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
