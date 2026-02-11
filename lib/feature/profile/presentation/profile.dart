import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/services/locale_service.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_bottom_sheet.dart';
import 'package:home_decor/core/widgets/my_button.dart';
import 'package:home_decor/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:home_decor/feature/profile/domain/entity/profile_entity.dart';
import 'package:home_decor/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_my_textbox.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_page_app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _selectedImage;
  String? _avatarBase64;

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
    _loadedDob = state.profile.dob ?? '';
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
                // Clear local image selection so network image can be displayed
                setState(() {
                  _selectedImage = null;
                  _avatarBase64 = null;
                });
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
                              Center(
                                child: GestureDetector(
                                  onTap: _pickAvatar,
                                  child: Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.grey.shade200,
                                        child: ClipOval(
                                          child: SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: _selectedImage != null
                                                ? Image.file(
                                                    _selectedImage!,
                                                    fit: BoxFit.cover,
                                                  )
                                                : (state.profile.imageUrl !=
                                                          null &&
                                                      state
                                                          .profile
                                                          .imageUrl!
                                                          .isNotEmpty)
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        state.profile.imageUrl!,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (
                                                          context,
                                                          url,
                                                        ) => const Center(
                                                          child: SizedBox(
                                                            width: 24,
                                                            height: 24,
                                                            child:
                                                                CircularProgressIndicator(
                                                                  strokeWidth:
                                                                      2,
                                                                ),
                                                          ),
                                                        ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(
                                                              Icons.person,
                                                              size: 50,
                                                            ),
                                                  )
                                                : const Icon(
                                                    Icons.person,
                                                    size: 50,
                                                  ),
                                          ),
                                        ),
                                      ),

                                      if (isEditClicked)
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: CircleAvatar(
                                            radius: 16,
                                            backgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            child: const Icon(
                                              Icons.camera_alt,
                                              size: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 15),
                              Column(
                                crossAxisAlignment: .start,
                                children: [
                                  ProfileMyTextbox(
                                    textFieldName: firstNameController.text
                                        .trim(),
                                    controller: firstNameController,
                                    enabled: isEditClicked,
                                    label: context.translate("first_name"),
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: lastNameController.text
                                        .trim(),
                                    controller: lastNameController,
                                    enabled: isEditClicked,
                                    label: context.translate("last_name"),
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: emailController.text.trim(),
                                    keyboardInputType:
                                        TextInputType.emailAddress,
                                    controller: emailController,
                                    enabled: false,
                                    label: context.translate("email"),
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: dobController.text.trim(),
                                    controller: dobController,
                                    iconData: Icons.date_range_outlined,
                                    enabled: isEditClicked,

                                    onIconTap: isEditClicked
                                        ? () => _selectDate(context)
                                        : null,
                                    label: context.translate("date_of_birth"),
                                    readOnly: true,
                                  ),

                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: phoneNumberController.text,
                                    keyboardInputType: TextInputType.number,
                                    controller: phoneNumberController,
                                    enabled: isEditClicked,
                                    label: context.translate("phone"),
                                  ),
                                  SizedBox(height: 15),

                                  ProfileMyTextbox(
                                    textFieldName: genderController.text.trim(),
                                    iconData: Icons.manage_accounts_outlined,
                                    controller: genderController,
                                    enabled: isEditClicked,

                                    onIconTap: isEditClicked
                                        ? () => _showGenderBottomSheet(context)
                                        : null,
                                    label: context.translate("gender"),
                                    readOnly: true,
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
                                        dob: dobController.text.trim(),
                                        imageUrl: _avatarBase64,
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
                          child: loadingShimmerState(),
                        );
                      }
                      return SizedBox.shrink();
                    },
                  ),
                  themeAndLanguage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column loadingShimmerState() {
    return Column(
      crossAxisAlignment: .start,
      children: [
        SizedBox(height: 15),
        Center(child: CircleAvatar(radius: 50)),
        SizedBox(height: 15),
        Column(
          crossAxisAlignment: .start,
          children: [
            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("first_name"),
            ),

            SizedBox(height: 15),

            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("last_name"),
            ),

            SizedBox(height: 15),

            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("email"),
            ),

            SizedBox(height: 15),

            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("date_of_birth"),
            ),

            SizedBox(height: 15),

            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("phone"),
            ),
            SizedBox(height: 15),

            ProfileMyTextbox(
              textFieldName: "",
              controller: loadingController,
              label: context.translate("gender"),
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
              function: () {},

              isEnabled: true,
            ),
            SizedBox(width: 15),
            MyButton(
              buttonTitle: context.translate('save'),
              function: () {},
              isEnabled: isEditClicked,
            ),
          ],
        ),
      ],
    );
  }

  Column themeAndLanguage() => Column(
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
      GestureDetector(
        onTap: () => _showLanguageBottomSheet(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.translate('language'),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),

      SizedBox(height: 150),
    ],
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900), // Adjust as needed
      lastDate: DateTime.now(), // Typically DOB can't be in the future
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
              onPrimary: Colors.white,
              onSurface: Theme.of(context).colorScheme.onSurface,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _showGenderBottomSheet(BuildContext context) {
    if (!isEditClicked) return;

    SelectionBottomSheet.show<String>(
      context,
      title: context.translate("Gender"),
      selectedValue: genderController.text,
      items: [
        SelectionItem(value: "Male", label: context.translate("male")),
        SelectionItem(value: "Female", label: context.translate("female")),
        SelectionItem(value: "Other", label: context.translate("other")),
      ],
      onSelected: (value) {
        setState(() {
          genderController.text = value;
        });
      },
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    SelectionBottomSheet.show<String>(
      context,
      title: context.translate("language"),
      selectedValue: Provider.of<LocaleService>(
        context,
        listen: false,
      ).currentLocale,

      items: [
        SelectionItem(value: 'en', label: context.translate('english')),

        SelectionItem(value: 'si', label: context.translate('sinhala')),
      ],
      onSelected: (value) {
        Provider.of<LocaleService>(context, listen: false).toggleLocale(value);
      },
    );
  }

  Future<void> _pickAvatar() async {
    if (!isEditClicked) return;

    final picker = ImagePicker();
    final XFile? picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70, // reduce size
    );

    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() {
        _selectedImage = File(picked.path);
        _avatarBase64 = base64Encode(bytes);
      });
    }
  }
}
