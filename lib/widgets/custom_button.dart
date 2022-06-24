import 'package:flutter/material.dart';
import 'package:projectuas/themes/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  CustomButton({required this.text, required this.onPressed, required this.backgroundColor});

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 51,
      margin: EdgeInsets.only(top: 50),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
        child: Text(
          text,
          style: whiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 15),
        ),
      ),
    );
  }
}
