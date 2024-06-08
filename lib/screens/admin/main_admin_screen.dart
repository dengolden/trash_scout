import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_scout/provider/bottom_navigation_provider.dart';
import 'package:trash_scout/screens/admin/admin_profile_screen.dart';
import 'package:trash_scout/screens/admin/admin_home_screen.dart';
import 'package:trash_scout/screens/admin/report_manage_screen.dart';
import 'package:trash_scout/shared/theme/theme.dart';
import 'package:trash_scout/shared/widgets/user/custom_bottom_navigation_item.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            buildContent(context),
            AdminBottomNavigation(),
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
      return AdminHomeScreen();
    case 1:
      return ReportManageScreen();
    case 2:
      return AdminProfileScreen();
    default:
      return AdminHomeScreen();
  }
}

class AdminBottomNavigation extends StatelessWidget {
  const AdminBottomNavigation({super.key});

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
                imageUrl: 'assets/document_icon.png',
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
