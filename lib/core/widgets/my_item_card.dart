import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_bloc.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_state.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_event.dart';
import '../../feature/product_detail/product_detail_page.dart';

class MyItemCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final double rating;
  final String? uuid;
  const MyItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.rating,
    this.uuid,
  });

  @override
  State<MyItemCard> createState() => _MyItemCardState();
}

class _MyItemCardState extends State<MyItemCard> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final double width = AppSizes.screenWidth(context);
    return GestureDetector(
      onTap: () {
        if (widget.uuid != null && widget.uuid!.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                title: widget.title,
                subtitle: widget.subtitle,
                imageUrl: widget.imageUrl,
                price: widget.price,
                rating: widget.rating,
                uuid: widget.uuid!,
              ),
            ),
          );
        } else {
          log("UUID is null or empty");
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeData.colorScheme.inversePrimary.withAlpha(25),
        ),
        width: width * 0.4,
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.imageUrl.isEmpty
                  ? SizedBox.shrink()
                  : Stack(
                      children: [
                        Hero(
                          tag: widget.uuid ?? widget.title,
                          child: Image(
                            width: double.infinity,
                            image: AssetImage(widget.imageUrl),
                            fit: BoxFit.fitWidth,
                            height: 130,
                          ),
                        ),

                        Positioned(
                          top: 8,
                          right: 8,
                          child: BlocBuilder<FavoritesBloc, FavoritesState>(
                            builder: (context, state) {
                              bool isCurrentlyFav = false;
                              if (state is FavoritesLoaded) {
                                isCurrentlyFav = state.isFavorite(
                                  widget.uuid ?? '',
                                );
                              }
                              return InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  if (widget.uuid != null) {
                                    context.read<FavoritesBloc>().add(
                                      ToggleFavoriteEvent(itemId: widget.uuid!),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isCurrentlyFav
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isCurrentlyFav
                                        ? AppColors.commonPrimary
                                        : Colors.white,
                                    size: 20,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(widget.subtitle, style: themeData.textTheme.bodySmall),
                  Text(
                    widget.title,
                    style: themeData.textTheme.bodyMedium!.copyWith(
                      color: AppColors.commonPrimary,
                    ),
                  ),
                  widget.imageUrl.isEmpty
                      ? SizedBox.shrink()
                      : Text(
                          "\$ ${widget.price}",
                          style: themeData.textTheme.bodyMedium,
                        ),
                  widget.imageUrl.isEmpty
                      ? SizedBox.shrink()
                      : Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 15,
                              color: AppColors.commonPrimary,
                            ),
                            Text(
                              "${widget.rating}",
                              style: themeData.textTheme.bodySmall,
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
