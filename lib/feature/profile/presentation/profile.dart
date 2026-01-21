import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/services/locale_service.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';
import 'package:home_decor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_my_textbox.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_page_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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
  TextEditingController loadingController = TextEditingController();

  bool isEditClicked = false;

  String _loadedFirstName = '';
  String _loadedLastName = '';
  String _loadedEmail = '';
  String _loadedDob = '';
  String _loadedPhoneNumber = '';
  String _loadedGender = '';
  bool _hasLoadedProfile = false;

  void _updateLoadedSnapshot(ProfileDataFetchSuccessState state) {
    _loadedFirstName = state.profile.firstName ?? '';
    _loadedLastName = state.profile.lastName ?? '';
    _loadedDob = state.profile.dob == null
        ? ''
        : DateFormat('yyyy-MM-dd').format(state.profile.dob!);
    _loadedGender = state.profile.gender ?? '';
    _loadedPhoneNumber = state.profile.phoneNumber ?? '';
    _loadedEmail = state.profile.email;
    _hasLoadedProfile = true;
  }

  void _restoreControllersFromSnapshot() {
    if (!_hasLoadedProfile) return;
    firstNameController.text = _loadedFirstName;
    lastNameController.text = _loadedLastName;
    dobController.text = _loadedDob;
    genderController.text = _loadedGender;
    phoneNumberController.text = _loadedPhoneNumber;
    emailController.text = _loadedEmail;
  }

  void _toggleEdit() {
    setState(() {
      if (isEditClicked) {
        _restoreControllersFromSnapshot();
        isEditClicked = false;
      } else {
        isEditClicked = true;
      }
    });
  }

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
    final themeData = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthonticatedState) {
          context.go('/signin');
        }
      },
      child: Scaffold(
        appBar: ProfilePageAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.screenWidth(context) * 0.02,
            vertical: AppSizes.screenHeight(context) * 0.01,
          ),
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileDataFetchSuccessState) {
                _updateLoadedSnapshot(state);

                // Initialize controllers with API values (only when not editing)
                if (!isEditClicked) {
                  _restoreControllersFromSnapshot();
                }
              }
              if (state is ProfileUpdateSuccessState) {
                BlocProvider.of<ProfileBloc>(
                  context,
                ).add(FetchUserDetailsEvent());
              }
              if (state is ProfileErrorState) {
                log("Error");
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileDataFetchSuccessState) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              SizedBox(height: 15),
                              Center(child: CircleAvatar(radius: 50)),
                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  ProfileMyTextbox(
                                    textFieldName: firstNameController.text
                                        .trim(),
                                    controller: firstNameController,
                                    enabled: isEditClicked,
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: lastNameController.text
                                        .trim(),
                                    controller: lastNameController,
                                    enabled: isEditClicked,
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: emailController.text.trim(),
                                    keyboardInputType:
                                        TextInputType.emailAddress,
                                    controller: emailController,
                                    enabled: false,
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: dobController.text.trim(),
                                    controller: dobController,
                                    iconData: Icons.date_range_outlined,
                                    enabled: isEditClicked,
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: phoneNumberController.text,
                                    keyboardInputType: TextInputType.number,
                                    controller: phoneNumberController,
                                    enabled: isEditClicked,
                                  ),
                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: genderController.text.trim(),
                                    iconData: Icons.manage_accounts_outlined,
                                    controller: genderController,
                                    enabled: isEditClicked,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  MyButton(
                                    buttonTitle: isEditClicked
                                        ? context.translate("cancel")
                                        : context.translate("edit"),
                                    function: _toggleEdit,

                                    isEnabled: true,
                                  ),
                                  SizedBox(width: 15),
                                  MyButton(
                                    buttonTitle: context.translate('save'),
                                    function: () {
                                      final updatedProfile = ProfileEntity(
                                        firstName: firstNameController.text
                                            .trim(),
                                        lastName: lastNameController.text
                                            .trim(),
                                        email: state
                                            .profile
                                            .email, // email usually not editable
                                        phoneNumber: phoneNumberController.text
                                            .trim(),
                                        gender: genderController.text.trim(),
                                        dob: dobController.text.isEmpty
                                            ? null
                                            : DateTime.parse(
                                                dobController.text.trim(),
                                              ),
                                      );

                                      BlocProvider.of<ProfileBloc>(context).add(
                                        SetUserDetailsEvent(
                                          profileEntity: updatedProfile,
                                        ),
                                      );

                                      setState(() {
                                        isEditClicked = false;
                                      });
                                    },
                                    isEnabled: isEditClicked,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is ProfileDataFetchLoadingState) {
                        return Shimmer.fromColors(
                          baseColor: themeData.colorScheme.inversePrimary,
                          highlightColor: themeData.colorScheme.primary,
                          enabled: true,
                          child: loading_shimmer_state(),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  theme_and_language(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column loading_shimmer_state() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(height: 15),
        Center(child: CircleAvatar(radius: 50)),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: .start,
          children: [
            ProfileMyTextbox(textFieldName: "", controller: loadingController),

            SizedBox(height: 15),

            ProfileMyTextbox(textFieldName: "", controller: loadingController),

            SizedBox(height: 15),

            ProfileMyTextbox(textFieldName: "", controller: loadingController),

            SizedBox(height: 15),

            ProfileMyTextbox(textFieldName: "", controller: loadingController),

            SizedBox(height: 15),

            ProfileMyTextbox(textFieldName: "", controller: loadingController),
            SizedBox(height: 15),

            ProfileMyTextbox(textFieldName: "", controller: loadingController),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            MyButton(
              buttonTitle: isEditClicked ? "Cancel" : "Edit",
              function: () {},

              isEnabled: true,
            ),
            SizedBox(width: 15),
            MyButton(
              buttonTitle: "Save",
              function: () {},
              isEnabled: isEditClicked,
            ),
          ],
        ),
      ],
    );
  }

  Column theme_and_language() => Column(
    children: [
      // Theme Toggle
      SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            context.translate("theme"),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Switch(
            value: Provider.of<ThemeService>(context).isDarkModeOn,
            onChanged: (_) {
              Provider.of<ThemeService>(context, listen: false).toggleTheme();
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
  );
}
