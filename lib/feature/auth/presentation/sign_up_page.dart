import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/validations/validations.dart';
import 'package:home_decor/core/widgets/my_app_snackbar.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/core/widgets/my_textbox.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

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

          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
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
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      focusNode: emailFocus,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                    ),

                    SizedBox(height: 20),

                    MyTextbox(
                      placeholder: 'password',
                      prefixIcon: Icons.password_outlined,
                      obsecureText: true,
                      controller: passwordController,
                      textInputAction: TextInputAction.next,
                      focusNode: passwordFocus,
                      onSubmitted: (_) {
                        FocusScope.of(
                          context,
                        ).requestFocus(confirmPasswordFocus);
                      },
                    ),

                    SizedBox(height: 20),

                    MyTextbox(
                      placeholder: 'confirm password',
                      prefixIcon: Icons.password_outlined,
                      obsecureText: true,
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: 40),

                    MyButton(
                      buttonTitle: "sign up",
                      function: signupButtonClicker,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signupButtonClicker() {
    if (emailController.text.isEmpty) {
      MyAppSnackbar.show(context, 'Email is required');
      return;
    }

    if (!Validations().isValidEmail(emailController.text)) {
      MyAppSnackbar.show(context, 'Enter a valid email address');
      return;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      MyAppSnackbar.show(context, 'Password must be at least 6 characters');
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      MyAppSnackbar.show(context, 'Password should same with confirm password');
      return;
    }

    BlocProvider.of<AuthBloc>(context).add(
      SignupButtonClickedEvent(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ),
    );
  }
}
