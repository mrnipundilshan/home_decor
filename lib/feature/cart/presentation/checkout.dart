import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_details.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_page_app_bar.dart';

class Checkout extends StatelessWidget {
  const Checkout({
    super.key,
    required this.total,
    required this.subtotal,
    required this.tax,
    required this.delivery,
  });

  final double total;
  final double subtotal;
  final double tax;
  final double delivery;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: CartPageAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: Column(
          children: [
            CartDetails(
              themeData: themeData,
              subtotal: subtotal,
              tax: tax,
              delivery: delivery,
              total: total,
              nextpage: () {},
            ),
          ],
        ),
      ),
    );
  }
}
