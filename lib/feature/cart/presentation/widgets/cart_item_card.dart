import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';

import 'package:home_decor/feature/cart/domain/entity/cart_entity.dart';

class CartItemCard extends StatefulWidget {
  final CartEntity cartItem;

  const CartItemCard({super.key, required this.cartItem});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  int quantity = 0;
  @override
  void initState() {
    super.initState();
    quantity = widget.cartItem.quantity!.toInt();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final item = widget.cartItem.itemEntity;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: themeData.colorScheme.inversePrimary.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 100,
              height: 100,
              child: item?.imageUrl != null
                  ? Image.asset(
                      item!.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey[800]),
                    )
                  : Container(color: Colors.grey[800]),
            ),
          ),
          const SizedBox(width: 16),

          // Details & Quantity
          Expanded(
            child: SizedBox(
              height: 100, // Match image height for vertical alignment
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item?.title ?? 'Unknown Item',
                        style: const TextStyle(
                          color: AppColors.commonPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$ ${item?.price?.toStringAsFixed(2) ?? "0.00"}',
                        style: themeData.textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  // Quantity Selector (Bottom Right aligned relative to content)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _QuantityButton(
                        icon: Icons.remove,
                        onTap: () {
                          setState(() {
                            quantity--;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$quantity',
                          style: themeData.textTheme.bodyMedium,
                        ),
                      ),
                      _QuantityButton(
                        icon: Icons.add,
                        onTap: () {
                          setState(() {
                            quantity++;
                          });
                        },
                        isFilled: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isFilled;

  const _QuantityButton({
    required this.icon,
    this.onTap,
    this.isFilled = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: isFilled ? AppColors.commonPrimary : Colors.transparent,
          shape: BoxShape.circle,
          border: isFilled
              ? null
              : Border.all(color: Colors.grey[700]!, width: 1.5),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isFilled ? themeData.colorScheme.primary : Colors.grey[600],
        ),
      ),
    );
  }
}
