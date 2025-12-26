import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:pinput/pinput.dart';

class MyPinput extends StatefulWidget {
  final TextEditingController pinController;
  final FocusNode focusNode;
  const MyPinput({
    super.key,
    required this.pinController,
    required this.focusNode,
  });

  @override
  State<MyPinput> createState() => _MyPinputState();
}

class _MyPinputState extends State<MyPinput> {
  final borderColor = AppColors.commonPrimary;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: themeData.textTheme.displaySmall,
      decoration: const BoxDecoration(),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: AppSizes.screenWidth(context) * 0.17,
          height: 3,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: AppSizes.screenWidth(context) * 0.17,
          height: 3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );

    return Pinput(
      length: 6,
      pinAnimationType: PinAnimationType.slide,
      controller: widget.pinController,
      focusNode: widget.focusNode,
      defaultPinTheme: defaultPinTheme,
      showCursor: true,
      cursor: cursor,
      preFilledWidget: preFilledWidget,
    );
  }
}
