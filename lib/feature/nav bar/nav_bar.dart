import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_decor/core/localization/translation_helper.dart';
import 'package:home_decor/core/theme/app_colors.dart';

class NavBar extends StatefulWidget {
  final Widget child;
  const NavBar({super.key, required this.child});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/category')) {
      return 1;
    }
    if (location.startsWith('/cart')) {
      return 2;
    }
    if (location.startsWith('/profile')) {
      return 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final int selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      extendBody: true,
      body: widget.child,
      backgroundColor: Colors.transparent,

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),

        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/category');
                break;
              case 2:
                context.go('/cart');
                break;
              case 3:
                context.go('/profile');
                break;
            }
          },

          type: BottomNavigationBarType.fixed,
          backgroundColor: themeData.colorScheme.primary,
          selectedItemColor: AppColors.commonPrimary,
          unselectedItemColor: themeData.colorScheme.inversePrimary,
          showSelectedLabels: true,
          showUnselectedLabels: true,

          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.home),
              ),
              label: context.translate('home'),
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.category),
              ),
              label: context.translate('category'),
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.shopping_cart),
              ),
              label: context.translate('cart'),
            ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.person),
              ),
              label: context.translate('profile'),
            ),
          ],
        ),
      ),
    );
  }
}
