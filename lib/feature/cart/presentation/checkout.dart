import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_details.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_page_app_bar.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    double subtotal = 0.0;
    double tax = 10.0;
    double delivery = 100.0;
    double total = 0;
    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: CartPageAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadedState) {
              for (var element in state.cartList) {
                subtotal += element.itemEntity!.price! * element.quantity!;
              }
              total = subtotal + tax + delivery;
              return state.cartList.isEmpty
                  ? const Center(child: Text("Cart is empty"))
                  : Column(
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
                    );
            }
            return const Center(child: Text("Cart is empty"));
          },
        ),
      ),
    );
  }
}
