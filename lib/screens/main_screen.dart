import 'package:flutter/material.dart';
import 'package:trash_scout/screens/home_screen.dart';
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
  return HomeScreen();
}

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
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
            CustomBottomNavigationItem(
              imageUrl: 'assets/home_icon.png',
              isActive: true,
            ),
            CustomBottomNavigationItem(
              imageUrl: 'assets/map_icon.png',
            ),
            CustomBottomNavigationItem(
              imageUrl: 'assets/profile_icon.png',
            ),
          ],
        ),
      ),
    );
  }
}
