import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_page_app_bar.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_item_card.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartInitialEvent());
  }

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
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartErrorState) {
              return const Center(child: Text("Error"));
            } else if (state is CartLoadedState) {
              return ListView.builder(
                itemCount: state.cartList.length,
                itemBuilder: (context, index) {
                  final cart = state.cartList[index];
                  return CartItemCard(
                    cartItem: cart,
                    onIncrement: () {
                      setState(() {
                        cart.quantity = (cart.quantity ?? 1) + 1;
                      });
                    },
                    onDecrement: () {
                      if ((cart.quantity ?? 1) > 1) {
                        setState(() {
                          cart.quantity = (cart.quantity ?? 1) - 1;
                        });
                      } else {
                        BlocProvider.of<CartBloc>(
                          context,
                        ).add(CartDeleteEvent(id: cart.id!));
                      }
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("No data"));
            }
          },
        ),
      ),
    );
  }
}
