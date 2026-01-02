import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
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
        if (state is AuthOtpSentSuccessState) {
          context.push("/otp", extra: emailController.text.trim());
        }

        if (state is AuthErrorState) {
          MyAppSnackbar.show(context, state.message);
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
                      context.translate('create_account'),
                      style: themeData.textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),

                    MyTextbox(
                      placeholder: context.translate('email_placeholder'),
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
                      placeholder: context.translate('password_placeholder'),
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
                      placeholder: context.translate('confirm_password_placeholder'),
                      prefixIcon: Icons.password_outlined,
                      obsecureText: true,
                      controller: confirmPasswordController,
                      focusNode: confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                    ),

                    SizedBox(height: 40),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoadingState) {
                          return MyButton(
                            isLoading: true,
                            buttonTitle: context.translate('sign_up'),
                            function: () {},
                          );
                        }
                        return MyButton(
                          isLoading: false,
                          buttonTitle: context.translate('sign_up'),
                          function: signupButtonClicker,
                        );
                      },
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: .center,
                      children: [
                        Text(
                          context.translate('already_have_account'),
                          style: themeData.textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/signin');
                          },
                          child: Text(
                            context.translate('sign_in'),
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
      MyAppSnackbar.show(context, context.translate('email_required'));
      return;
    }

    if (!Validations().isValidEmail(emailController.text)) {
      MyAppSnackbar.show(context, context.translate('email_invalid'));
      return;
    }

    if (passwordController.text.isEmpty || passwordController.text.length < 6) {
      MyAppSnackbar.show(context, context.translate('password_min_length'));
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      MyAppSnackbar.show(context, context.translate('password_mismatch'));
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
