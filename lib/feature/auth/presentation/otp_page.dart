import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_app_snackbar.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/core/widgets/my_pinput.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          context.go("/signin");
        }

        if (state is AuthErrorState) {
          MyAppSnackbar.show(context, state.message);
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
                  context.translate('enter_otp'),
                  style: themeData.textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                MyPinput(pinController: pinController, focusNode: focusNode),
                SizedBox(height: 40),

                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return MyButton(
                        isLoading: true,
                        buttonTitle: context.translate('sign_in'),
                        function: () {},
                      );
                    }
                    return MyButton(
                      isLoading: false,
                      buttonTitle: context.translate('sign_in'),
                      function: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          SigupOtpVerifyButtonClickedEvent(
                            email: widget.email,
                            otp: pinController.text,
                          ),
                        );
                      },
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
    );
  }
}
