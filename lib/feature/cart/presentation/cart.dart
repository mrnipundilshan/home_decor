import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_details.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_page_app_bar.dart';
import 'package:home_decor/feature/cart/presentation/widgets/cart_item_card.dart';
import 'package:shimmer/shimmer.dart';

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
            if (state is CartLoadingState) {
              return Shimmer.fromColors(
                baseColor: themeData.colorScheme.inversePrimary,
                highlightColor: themeData.colorScheme.primary,
                enabled: true,
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CartItemCard(cartItem: CartEntity());
                  },
                ),
              );
            } else if (state is CartErrorState) {
              return const Center(child: Text("Error"));
            } else if (state is CartLoadedState) {
              for (var element in state.cartList) {
                subtotal += element.itemEntity!.price! * element.quantity!;
              }
              total = subtotal + tax + delivery;
              return state.cartList.isEmpty
                  ? const Center(child: Text("Cart is empty"))
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.cartList.length,
                            itemBuilder: (context, index) {
                              final cart = state.cartList[index];
                              return CartItemCard(
                                cartItem: cart,
                                onIncrement: () {
                                  BlocProvider.of<CartBloc>(context).add(
                                    CartUpdateEvent(
                                      id: cart.id!,
                                      quantity: (cart.quantity ?? 1) + 1,
                                    ),
                                  );
                                  setState(() {
                                    cart.quantity = (cart.quantity ?? 1) + 1;
                                  });
                                },
                                onDecrement: () {
                                  if ((cart.quantity ?? 1) > 1) {
                                    BlocProvider.of<CartBloc>(context).add(
                                      CartUpdateEvent(
                                        id: cart.id!,
                                        quantity: (cart.quantity ?? 1) - 1,
                                      ),
                                    );
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
                          ),
                        ),
                        CartDetails(
                          themeData: themeData,
                          subtotal: subtotal,
                          tax: tax,
                          delivery: delivery,
                          total: total,
                          nextpage: () => context.push('/checkout'),
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
