import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/core/widgets/my_textbox.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppSizes.defaultPadding(context),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Signin To decoze",
                  style: themeData.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                MyTextbox(
                  placeholder: 'user@gmail.com',
                  prefixIcon: Icons.mail_outline_outlined,
                  obsecureText: false,
                  controller: emailController,
                ),

                SizedBox(height: 20),

                MyTextbox(
                  placeholder: 'password',
                  prefixIcon: Icons.password_outlined,
                  obsecureText: true,
                  controller: passwordController,
                ),

                SizedBox(height: 40),

                MyButton(
                  buttonTitle: "Sign in",
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
                      "Haven't an account? ",
                      style: themeData.textTheme.bodyMedium,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.push('/signup');
                      },
                      child: Text(
                        "Sign up",
                        style: TextStyle(color: AppColors.commonPrimary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
