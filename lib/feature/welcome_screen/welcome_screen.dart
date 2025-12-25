import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});


  @override
  Widget build(BuildContext context) {

    void navigateToOnbordingPage(){
      context.push('/onboarding');
    }

    final themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.defaultPadding(context),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset("assets/logo.png"),
                  SizedBox(height: 20),
                  Text("Welcome to", style: themeData.textTheme.headlineLarge),
                  Text("Decoz", style: AppCustomTextStyles.splashScreenText),
                  SizedBox(height: 10),
                  Text(
                    textAlign: TextAlign.center,
                    "Style your spaces & shop for all\nyour decor needs",
                    style: AppCustomTextStyles.splashbody,
                  ),
                ],
              ),

              Column(
                children: [
                  MyButton(
                      buttonTitle: 'Get Started',
                      function: navigateToOnbordingPage
                  ),
                  SizedBox(height: 100),
                ],
              ),


            ],
          ),
        ),
      ),
    );
  }
}