import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final String imageUrl;
  final bool isActive;

  const CustomBottomNavigationItem({
    required this.imageUrl,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(),
        Image.asset(
          imageUrl,
          width: 30,
          height: 30,
          // color:
        ),
        Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            color: isActive ? darkGreenColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
