import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';
import 'package:home_decor/feature/home/presentation/widgets/top%20selling/top_selling_card.dart';
import 'package:shimmer/shimmer.dart';

class TopSelling extends StatefulWidget {
  const TopSelling({super.key});

  @override
  State<TopSelling> createState() => _TopSellingState();
}

class _TopSellingState extends State<TopSelling> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(HomePageInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = AppSizes.screenWidth(context);
    final themeData = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          SizedBox(height: 15),
          Text("Top Selling"),
          SizedBox(height: 10),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeTopSellingLoadingState) {
                return Shimmer.fromColors(
                  baseColor: themeData.colorScheme.inversePrimary,
                  highlightColor: themeData.colorScheme.primary,
                  enabled: true,
                  child: SizedBox(
                    height: width * 0.66,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: .horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return TopSellingCard(
                          title: "",
                          subtitle: "",
                          imageUrl: "",
                          price: 0,
                          rating: 0,
                        );
                      },
                    ),
                  ),
                );
              }
              if (state is HomeTopSellingLoadedState) {
                return SizedBox(
                  height: width * 0.66,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: .horizontal,
                    itemCount: state.topSellingItems.length,
                    itemBuilder: (context, index) {
                      final topSellingItem = state.topSellingItems[index];
                      return TopSellingCard(
                        title: topSellingItem.title,
                        subtitle: topSellingItem.subtitle,
                        imageUrl: topSellingItem.imageUrl,
                        price: topSellingItem.price,
                        rating: topSellingItem.rating,
                      );
                    },
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
