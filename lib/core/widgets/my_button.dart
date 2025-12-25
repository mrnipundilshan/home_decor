import 'package:flutter/cupertino.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';

class MyButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback function;

  const MyButton({
    super.key,
    required this.buttonTitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        sizeStyle: CupertinoButtonSize.medium,
        borderRadius: BorderRadius.circular(40),
        color: AppColors.commonPrimary,
        child: Text(buttonTitle, style: AppCustomTextStyles.buttonText),
        onPressed: () => function(),

      ),
    );
  }
}
