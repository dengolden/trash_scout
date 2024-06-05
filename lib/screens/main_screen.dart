import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_scout/provider/bottom_navigation_provider.dart';
import 'package:trash_scout/screens/home_screen.dart';
import 'package:trash_scout/screens/map_screen.dart';
import 'package:trash_scout/screens/profile_screen.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/custom_bottom_navigation_item.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            buildContent(context),
            CustomBottomNavigation(),
          ],
        ),
      ),
    );
  }
}

Widget buildContent(BuildContext context) {
  final navigationProvider = Provider.of<BottomNavigationProvider>(context);
  int currentIndex = navigationProvider.currentIndex;

  switch (currentIndex) {
    case 0:
      return HomeScreen();
    case 1:
      return MapScreen(); // Replace with your map screen
    case 2:
      return ProfileScreen(); // Replace with your profile screen
    default:
      return HomeScreen();
  }
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 55,
        padding: EdgeInsets.symmetric(
          horizontal: 54,
          vertical: 9,
        ),
        margin: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => navigationProvider.currentIndex = 0,
              child: CustomBottomNavigationItem(
                imageUrl: 'assets/home_icon.png',
                index: 0,
              ),
            ),
            GestureDetector(
              onTap: () => navigationProvider.currentIndex = 1,
              child: CustomBottomNavigationItem(
                imageUrl: 'assets/map_icon.png',
                index: 1,
              ),
            ),
            GestureDetector(
              onTap: () => navigationProvider.currentIndex = 2,
              child: CustomBottomNavigationItem(
                imageUrl: 'assets/profile_icon.png',
                index: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
