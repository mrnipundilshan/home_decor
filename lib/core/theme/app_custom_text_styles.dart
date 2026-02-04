import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCustomTextStyles {
  static const TextStyle splashScreenText = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    color: AppColors.commonPrimary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const TextStyle splashTitle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
  );

  static const splashbody = TextStyle(
    fontFamily: "Rubik",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const priceText = TextStyle(
    fontFamily: "Rubik",
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: AppColors.commonPrimary,
  );

  static const ratingText = TextStyle(
    fontFamily: "Rubik",
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.commonPrimary,
  );

  static const subtitleText = TextStyle(
    fontFamily: "Rubik",
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  static final descriptionText = subtitleText.copyWith(
    color: Colors.grey.shade600,
  );
}
