import 'package:flutter/material.dart';
import 'package:home_decor/core/theme/app_colors.dart';
import 'package:home_decor/feature/home/presentation/home_page.dart';
import 'package:home_decor/feature/profile/profile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    Center(child: Text("Search")),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      backgroundColor: Colors.transparent,

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
          },

          type: BottomNavigationBarType.fixed,
          backgroundColor: themeData.colorScheme.primary,
          selectedItemColor: AppColors.commonPrimary,
          unselectedItemColor: themeData.colorScheme.inversePrimary,
          showSelectedLabels: true,
          showUnselectedLabels: true,

          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.home),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.search),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Icon(Icons.person),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
