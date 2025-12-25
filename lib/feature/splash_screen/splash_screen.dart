import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';

import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // initial full visibility

  @override
  void initState() {
    super.initState();
    _startFadeOut();
  }

  void _startFadeOut() async {
    // Wait 1.5 seconds before starting fade
    await Future.delayed(const Duration(milliseconds: 1500));

    // Start fade
    setState(() => _opacity = 0.0);

    // Wait for fade animation to complete (duration matches AnimatedOpacity)
    await Future.delayed(const Duration(milliseconds: 500));

    // Navigate after fade
    if (!mounted) return;
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashScreenColor,
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png"),
              const SizedBox(height: 12),
              const Text(
                "Decoz",
                style: AppCustomTextStyles.splashScreenText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

