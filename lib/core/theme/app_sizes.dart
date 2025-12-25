import 'package:flutter/widgets.dart';

class AppSizes {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double defaultPadding(BuildContext context) =>
      screenWidth(context) * 0.04;

  static double smallPadding(BuildContext context) =>
      screenWidth(context) * 0.02;
}
