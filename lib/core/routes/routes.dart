import 'package:go_router/go_router.dart';
import 'package:home_decor/feature/auth/presentation/otp_page.dart';
import 'package:home_decor/feature/auth/presentation/sign_in_page.dart';
import 'package:home_decor/feature/home/presentation/home_page.dart';
import 'package:home_decor/feature/splash_screen/splash_screen.dart';
import 'package:home_decor/feature/welcome_screen/welcome_screen.dart';
import 'package:home_decor/injection.dart';

import '../../feature/auth/presentation/sign_up_page.dart';
import '../../feature/onborading_page/onboarding_page.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name:
          'splashScreen', // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => SplashScreen(authLocalDatasource: sl()),
    ),
    GoRoute(
      name: 'welcomeScreen',
      path: '/welcome',
      builder: (context, state) => WelcomeScreen(),
    ),
    GoRoute(
      name: 'onboardingScreen',
      path: '/onboarding',
      builder: (context, state) => OnboardingPage(),
    ),
    GoRoute(
      name: 'signupScreen',
      path: '/signup',
      builder: (context, state) => SignUpPage(),
    ),

    GoRoute(
      name: 'signinScreen',
      path: '/signin',
      builder: (context, state) => SignInPage(),
    ),

    GoRoute(
      name: 'otpScreen',
      path: '/otp',
      builder: (context, state) {
        final email = state.extra as String;
        return OtpPage(email: email);
      },
    ),

    GoRoute(
      name: 'homepageScreen',
      path: '/homepage',
      builder: (context, state) => HomePage(),
    ),
  ],
);
