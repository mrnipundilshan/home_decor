import 'package:flutter/material.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/profile/widgets/profile_page_app_bar.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfilePageAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Switch(
              value: Provider.of<ThemeService>(context).isDarkModeOn,
              onChanged: (_) {
                Provider.of<ThemeService>(context, listen: false).toggleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
