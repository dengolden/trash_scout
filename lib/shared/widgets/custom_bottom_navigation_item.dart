import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trash_scout/provider/bottom_navigation_provider.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String imageUrl;
  final int index;

  const CustomBottomNavigationItem({
    required this.imageUrl,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);
    final isActive = bottomNavigationProvider.currentIndex == index;

    return Column(
      children: [
        SizedBox(),
        Image.asset(
          imageUrl,
          width: 30,
          height: 30,
          color: isActive ? lightGreenColor : whiteColor,
        ),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? lightGreenColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
