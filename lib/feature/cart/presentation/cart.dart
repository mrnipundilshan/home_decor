import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          height: 300,
                          decoration: BoxDecoration(
                            color: themeData.cardColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            border: Border.all(
                              color: themeData.dividerColor.withAlpha(50),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(20),
                                blurRadius: 20,
                                offset: const Offset(0, -10),
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "$subtotal",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tax and Fees",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$ $tax",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Delivery",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$ $delivery",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Text(
                                    "Total",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "\$ $total",
                                    style: themeData.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              MyButton(
                                buttonTitle: "Checkout",
                                isLoading: false,
                                function: () {},
                              ),
                            ],
                          ),
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
