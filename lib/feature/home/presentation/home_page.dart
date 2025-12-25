import 'package:flutter/material.dart';
import 'package:home_decor/core/services/theme_service.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/feature/home/presentation/widgets/my_appbar.dart';
import 'package:home_decor/feature/home/presentation/widgets/catgory%20carousel/my_carousel_view.dart';
import 'package:home_decor/feature/home/presentation/widgets/my_image_slider.dart';
import 'package:home_decor/feature/home/presentation/widgets/top%20selling/top_selling.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.canvasColor,
      appBar: MyAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.screenWidth(context) * 0.02,
          vertical: AppSizes.screenHeight(context) * 0.01,
        ),
        child: Column(
          children: [
            MyImageSlider(),
            SizedBox(height: 15),
            MyCarouselView(),
            TopSelling(),
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
