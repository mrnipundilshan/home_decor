import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/widgets/my_button.dart';

class CartDetails extends StatelessWidget {
  const CartDetails({
    super.key,
    required this.themeData,
    required this.subtotal,
    required this.tax,
    required this.delivery,
    required this.total,
    required this.nextpage,
  });

  final ThemeData themeData;
  final double subtotal;
  final double tax;
  final double delivery;
  final double total;
  final VoidCallback? nextpage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 330,
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
                context.translate("subtotal"),
                style: themeData.textTheme.titleMedium,
              ),
              const Spacer(),
              Text("$subtotal", style: themeData.textTheme.titleMedium),
            ],
          ),
          Row(
            children: [
              Text(
                context.translate("tax"),
                style: themeData.textTheme.titleMedium,
              ),
              const Spacer(),
              Text("\$ $tax", style: themeData.textTheme.titleMedium),
            ],
          ),
          Row(
            children: [
              Text(
                context.translate("delivery"),
                style: themeData.textTheme.titleMedium,
              ),
              const Spacer(),
              Text("\$ $delivery", style: themeData.textTheme.titleMedium),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Text(
                context.translate("total"),
                style: themeData.appBarTheme.titleTextStyle,
              ),
              const Spacer(),
              Text("\$ $total", style: AppCustomTextStyles.priceText),
            ],
          ),
          SizedBox(height: 10),
          MyButton(
            buttonTitle: context.translate("checkout"),
            isLoading: false,
            function: nextpage!,
          ),
        ],
      ),
    );
  }
}
