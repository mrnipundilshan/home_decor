import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/core/widgets/my_textbox.dart';
import 'package:home_decor/feature/auth/bloc/auth_bloc.dart';
import 'package:provider/provider.dart';

import '../../core/services/theme_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          context.go("/homepage");
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppSizes.defaultPadding(context),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create your\ndecoze account",
                  style: themeData.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                MyTextbox(
                  placeholder: 'user@gmail.com',
                  prefixIcon: Icons.mail_outline_outlined,
                  obsecureText: false,
                ),

                SizedBox(height: 20),

                MyTextbox(
                  placeholder: 'password',
                  prefixIcon: Icons.password_outlined,
                  obsecureText: true,
                ),

                SizedBox(height: 20),

                MyTextbox(
                  placeholder: 'confirm password',
                  prefixIcon: Icons.password_outlined,
                  obsecureText: true,
                ),

                SizedBox(height: 40),

                MyButton(
                  buttonTitle: "sign up",
                  function: () {
                    BlocProvider.of<AuthBloc>(
                      context,
                    ).add(SinginButtonClickedEvent());
                  },
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: .center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: themeData.textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/signin');
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(color: AppColors.commonPrimary),
                      ),
                    ),
                  ],
                ),

                Switch(
                  value: Provider.of<ThemeService>(context).isDarkModeOn,
                  onChanged: (_) {
                    Provider.of<ThemeService>(
                      context,
                      listen: false,
                    ).toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
