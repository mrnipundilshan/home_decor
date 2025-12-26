import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_decor/base_app.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/home/presentation/bloc/home_bloc.dart';
import 'package:home_decor/injection.dart' as di;
import 'package:provider/provider.dart';

import 'core/services/theme_service.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => di.sl<HomeBloc>()),
      ],

      child: const BaseApp(),
    ),
  );
}
