import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';

class ItemCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double price;
  final double rating;
  const ItemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: themeData.colorScheme.inversePrimary.withAlpha(25),
      ),

      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: widget.imageUrl.isEmpty
                ? SizedBox.shrink()
                : Stack(
                    children: [
                      Image(
                        width: double.infinity,
                        image: AssetImage(widget.imageUrl),
                        fit: BoxFit.fitWidth,
                      ),

                      Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              isFav = !isFav;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isFav == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFav == true
                                  ? AppColors.commonPrimary
                                  : Colors.white,
                              size: 20,
                            ),
                          ),
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
    );
  }
}
