import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/cart/presentation/widgets/address_inputer.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_details.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_page_app_bar.dart';

class Checkout extends StatefulWidget {
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
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    cityController.dispose();
    zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: const CartPageAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: AppSizes.screenWidth(context) * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddressInputer(
              nameController: nameController,
              addressController: addressController,
              cityController: cityController,
              zipController: zipController,
            ),

            CartDetails(
              isCheckout: true,
              themeData: themeData,
              subtotal: widget.subtotal,
              tax: widget.tax,
              delivery: widget.delivery,
              total: widget.total,
              nextpage: () {},
            ),
          ],
        ),
      ),
    );
  }
}
