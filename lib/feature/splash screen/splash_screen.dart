import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_custom_text_styles.dart';
import 'package:home_decor/feature/auth/domain/usecases/auth_usecases.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

import '../../core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  final AuthUsecases authUsecases;
  const SplashScreen({super.key, required this.authUsecases});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0; // initial full visibility

  @override
  void initState() {
    super.initState();
    _handleStartup();
  }

  void _handleStartup() async {
    // Wait 1.5 seconds before starting fade
    await Future.delayed(const Duration(milliseconds: 1500));

    // Start fade
    setState(() => _opacity = 0.0);

    // Wait for fade animation to complete (duration matches AnimatedOpacity)
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      BlocProvider.of<AuthBloc>(context).add(CheckLoggedEvent());
    }

    // Navigate after fade
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthonticatedState) {
          context.go('/welcome');
        }
        if (state is AuthonticatedState) {
          context.go('/navbar');
        }
      },
      child: Scaffold(
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
                Text(
                  context.translate('decoz'),
                  style: AppCustomTextStyles.splashScreenText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
