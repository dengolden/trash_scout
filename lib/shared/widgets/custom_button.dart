import 'package:flutter/material.dart';
import 'package:trash_scout/shared/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const CustomButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: darkGreenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          buttonText,
          style: semiBoldTextStyle.copyWith(
            color: whiteColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
