import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:home_decor/base_app.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:home_decor/feature/category/presentation/bloc/category_bloc.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_bloc.dart';
import 'package:home_decor/feature/wishlist/presentation/bloc/favorites_event.dart';
import 'package:home_decor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:home_decor/injection.dart' as di;
import 'package:provider/provider.dart';

import 'core/services/theme_service.dart';
import 'core/services/locale_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await di.init();
  Stripe.publishableKey =
      "pk_test_51SyvPB5WSlvwIpTrBVsFzXxy4rVE2cnbza8qmIibs8Lc7hUmXAoOvHmukPyNaWubvpL4Imkmkds7cjDrPco5emWw009TqOIEaU";
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider(create: (context) => LocaleService()),
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<HomeBloc>()),
        BlocProvider(
          create: (context) =>
              di.sl<FavoritesBloc>()..add(LoadFavoritesEvent()),
        ),
        BlocProvider(create: (context) => di.sl<ProfileBloc>()),
        BlocProvider(create: (context) => di.sl<CategoryBloc>()),
        BlocProvider(create: (context) => di.sl<CartBloc>()),
      ],

      child: const BaseApp(),
    ),
  );
}
