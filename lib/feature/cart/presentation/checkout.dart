import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_app_snackbar.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
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
  final addressController2 = TextEditingController();
  final addressController3 = TextEditingController();
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

    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is CartPaymentLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is CartPaymentSuccessState) {
          Navigator.pop(context);
          MyAppSnackbar.show(context, "Payment Successful!", isSuccess: true);
          context.go('/home');
        } else if (state is CartPaymentErrorState) {
          Navigator.pop(context);
          MyAppSnackbar.show(context, state.message);
        }
      },
      child: Scaffold(
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
                addressController2: addressController2,
                addressController3: addressController3,
              ),
              CartDetails(
                isCheckout: true,
                themeData: themeData,
                subtotal: widget.subtotal,
                tax: widget.tax,
                delivery: widget.delivery,
                total: widget.total,
                nextpage: () {
                  context.read<CartBloc>().add(
                    CartStripePaymentEvent(
                      amount: widget.total,
                      currency: 'usd',
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
