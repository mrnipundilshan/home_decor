import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';

class MyImageSlider extends StatefulWidget {
  const MyImageSlider({super.key});

  @override
  State<MyImageSlider> createState() => _MyImageSliderState();
}

class _MyImageSliderState extends State<MyImageSlider> {
  int currentPage = 0;

  late PageController _pageController;
  Timer? _timer;

  final List<Map<String, String>> splashData = [
    {"image": "assets/homepage_banner.png"},
    {"image": "assets/homepage_banner.png"},
    {"image": "assets/homepage_banner.png"},
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentPage < splashData.length - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      _pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.screenHeight(context) * 0.2,
      child: Column(
        mainAxisAlignment: .start,
        children: [
          Flexible(
            flex: 1,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: splashData.length,
              itemBuilder: (context, index) =>
                  SplashContent(image: splashData[index]["image"]),
            ),
          ),

          Flexible(
            flex: 0,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    splashData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      width: currentPage == index ? 20 : 6,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? AppColors.commonPrimary
                            : const Color(0xFFD8D8D8),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({super.key, this.image});
  final String? image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[Image.asset(widget.image!, height: 150)]);
  }
}
