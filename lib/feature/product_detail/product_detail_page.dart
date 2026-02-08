import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final double rating;
  final String uuid;

  const ProductDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.uuid,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final themeData = Theme.of(context);
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartAddedSuccessState) {
          Navigator.of(context).pop();
        }
        if (state is CartErrorState) {
          print("object");
        }
      },
      child: Scaffold(
        backgroundColor: themeData.scaffoldBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: height * 0.3,
              pinned: true,
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: widget.uuid,
                  child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 20,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title + rating
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.title,
                            style: themeData.textTheme.titleLarge,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.commonPrimary.withAlpha(20),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: AppColors.commonPrimary,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                widget.rating.toString(),
                                style: AppCustomTextStyles.ratingText,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.subtitle,
                      style: AppCustomTextStyles.subtitleText,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${widget.price.toStringAsFixed(2)}",
                          style: AppCustomTextStyles.priceText,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (count == 1) return;
                                  setState(() {
                                    count--;
                                  });
                                },
                                icon: const Icon(Icons.remove),
                                color: count == 1
                                    ? Colors.grey
                                    : AppColors.commonPrimary,
                              ),
                              Text(
                                "$count",
                                style: themeData.appBarTheme.titleTextStyle,
                              ),
                              IconButton(
                                onPressed: () {
                                  if (count == 25) return;
                                  setState(() {
                                    count++;
                                  });
                                },
                                icon: const Icon(Icons.add),
                                color: count == 25
                                    ? Colors.grey
                                    : AppColors.commonPrimary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Text("Description", style: themeData.textTheme.titleLarge),
                    const SizedBox(height: 12),
                    Text(
                      "Elevate your living space with this exquisite piece. Designed with modern aesthetics and premium materials, it offers both comfort and style. Perfect for any contemporary home, this item blends functionality with elegance to create a warm and inviting atmosphere.",
                      style: AppCustomTextStyles.descriptionText,
                    ),
                    const SizedBox(height: 48), // Bottom padding
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 12.0,
            ),
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return MyButton(
                    buttonTitle: "Adding...",
                    isEnabled: false,
                    isLoading: true,
                    function: () {},
                  );
                }
                return MyButton(
                  buttonTitle: "Add to Cart",
                  isLoading: false,
                  function: () {
                    BlocProvider.of<CartBloc>(
                      context,
                    ).add(CartAddEvent(itemId: widget.uuid, quantity: count));
                  },
                );
              },
            ),

            //  ElevatedButton(
            //   onPressed: () {
            //     BlocProvider.of<CartBloc>(
            //       context,
            //     ).add(CartAddEvent(itemId: widget.uuid, quantity: count));
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.commonPrimary,
            //     padding: const EdgeInsets.symmetric(vertical: 16),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     elevation: 0,
            //   ),
            //   child: BlocBuilder<CartBloc, CartState>(
            //     builder: (context, state) {
            //       if (state is CartLoadingState) {
            //         return const Text(
            //           "Adding...",
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         );
            //       }
            //       return const Text(
            //         "Add to Cart",
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ),
        ),
      ),
    );
  }
}
