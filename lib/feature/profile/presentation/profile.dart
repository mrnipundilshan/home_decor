import 'package:flutter/material.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/services/locale_service.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/profile/presentation/widgets/profile_page_app_bar.dart';
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Theme Toggle
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
          ],
        ),
      ),
    );
  }
}
