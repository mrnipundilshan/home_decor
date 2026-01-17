import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/services/locale_service.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_my_textbox.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_page_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late TextEditingController firstNameController;
  late TextEditingController emailController;
  late TextEditingController lastNameController;
  late TextEditingController dobController;
  late TextEditingController phoneNumberController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    dobController = TextEditingController();
    phoneNumberController = TextEditingController();
    genderController = TextEditingController();

    BlocProvider.of<ProfileBloc>(context).add(FetchUserDetailsEvent());
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfilePageAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileDataFetchSuccessState) {
              // Initialize controllers with API values when state is received
              firstNameController.text = state.profile.firstName ?? '';
              lastNameController.text = state.profile.lastName ?? '';
              dobController.text = DateFormat(
                'yyyy-MM-dd',
              ).format(state.profile.dob!);
              genderController.text = state.profile.gender ?? '';
              phoneNumberController.text = state.profile.phoneNumber ?? '';
              emailController.text = state.profile.email;
            }
          },
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileDataFetchSuccessState) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Center(child: CircleAvatar(radius: 50)),
                      SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          ProfileMyTextbox(
                            textFieldName: firstNameController.text,

                            controller: firstNameController,
                          ),

                          SizedBox(height: 15),

                          ProfileMyTextbox(
                            textFieldName: lastNameController.text,

                            controller: lastNameController,
                          ),

                          SizedBox(height: 15),

                          ProfileMyTextbox(
                            textFieldName: emailController.text,

                            controller: emailController,
                          ),

                          SizedBox(height: 15),

                          ProfileMyTextbox(
                            textFieldName: dobController.text,
                            controller: dobController,
                          ),

                          SizedBox(height: 15),

                          ProfileMyTextbox(
                            textFieldName: phoneNumberController.text,

                            controller: phoneNumberController,
                          ),
                          SizedBox(height: 15),

                          ProfileMyTextbox(
                            textFieldName: genderController.text,

                            controller: genderController,
                          ),
                        ],
                      ),

                      // Theme Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.translate("theme"),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Switch(
                            value: Provider.of<ThemeService>(
                              context,
                            ).isDarkModeOn,
                            onChanged: (_) {
                              Provider.of<ThemeService>(
                                context,
                                listen: false,
                              ).toggleTheme();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Language Switcher
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            context.translate('language'),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Consumer<LocaleService>(
                            builder: (context, localeService, child) {
                              return DropdownButton<String>(
                                value: localeService.currentLocale,
                                items: [
                                  DropdownMenuItem(
                                    value: 'en',
                                    child: Text(context.translate('english')),
                                  ),
                                  DropdownMenuItem(
                                    value: 'si',
                                    child: Text(context.translate('sinhala')),
                                  ),
                                ],
                                onChanged: (String? newLocale) {
                                  if (newLocale != null) {
                                    localeService.toggleLocale(newLocale);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                );
              }
              if (state is ProfileDataFetchLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
