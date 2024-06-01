import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class TrashCategoryItem extends StatelessWidget {
  final bool isClicked;
  final String title;

  const TrashCategoryItem({
    required this.title,
    this.isClicked = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: isClicked ? lightGreenColor : darkGreenColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
            style: regularTextStyle.copyWith(
              color: whiteColor,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
