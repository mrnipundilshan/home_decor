import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/core/theme/app_sizes.dart';
import 'package:home_decor/core/widgets/my_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Effortlessly organize your decor and shopping with decoze",
      "subtitle":
          "Confidently navigate your decor journey, ensuring a stylish and productive path to your dream space with decoze",
      "image": "assets/onbordingscreenimage1.png",
    },
    {
      "title": "Stay connected with design team anytime, anywhere with decoze",
      "subtitle":
          "In today's dynamic decor world, staying connected with your design team is key to success with decoze",
      "image": "assets/onbordingscreenimage2.png",
    },
    {
      "title": "Discover all the features decoze has to offer",
      "subtitle":
          "Dive into decoze's multitude of features by exploring its diverse functionalities",
      "image": "assets/onbordingscreenimage3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      //backgroundColor: AppColors.splashScreenColor,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppSizes.defaultPadding(context)),
            child: Column(
              children: [
                SizedBox(height: 50),
                Flexible(
                  flex: 3,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) => SplashContent(
                      image: splashData[index]["image"],
                      title: splashData[index]['title'],
                      subtitle: splashData[index]['subtitle'],
                    ),
                  ),
                ),
            
            
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
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
            
            
                        const Spacer(flex: 3),
                        MyButton(buttonTitle: "Skip", function: () {
                          context.go('/signup');
                        }),
                        const SizedBox(height: 100,),
                      ],
                    ),
                  ),
                ),
            
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SplashContent extends StatefulWidget {
  const SplashContent({super.key, this.title, this.subtitle, this.image});
  final String? title, subtitle, image;

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: <Widget>[
        const Spacer(),
        Image.asset(widget.image!, height: 265),
        const SizedBox(height: 50),

        Text(widget.title!, textAlign: TextAlign.center),
        const SizedBox(height: 10),

        Text(widget.subtitle!,style: themeData.textTheme.bodySmall, textAlign: TextAlign.center),
        const Spacer(flex: 2),

      ],
    );
  }
}

