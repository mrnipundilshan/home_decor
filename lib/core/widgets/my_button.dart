import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyButton extends StatefulWidget {
  final String buttonTitle;
  final VoidCallback function;
  final bool? isLoading;
  final bool? isEnabled;

  const MyButton({
    super.key,
    required this.buttonTitle,
    required this.function,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.isEnabled! ? 1 : 0.1,
      child: SizedBox(
        width: double.infinity,
        height: AppSizes.screenHeight(context) * 0.06,
        child: CupertinoButton(
          sizeStyle: CupertinoButtonSize.medium,
          borderRadius: BorderRadius.circular(40),
          onPressed: () =>
              widget.isEnabled! ? widget.function() : log("Button Not Enabled"),
          color: AppColors.commonPrimary,
          child: widget.isLoading!
              ? SizedBox(
                  height: AppSizes.screenHeight(context) * 0.04,
                  width: AppSizes.screenHeight(context) * 0.04,
                  child: CircularProgressIndicator(),
                )
              : Text(widget.buttonTitle, style: AppCustomTextStyles.buttonText),
        ),
      ),
    );
  }
}
