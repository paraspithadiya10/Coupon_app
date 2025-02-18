import 'package:flutter/material.dart';

class SocialButtonsWidget extends StatelessWidget {
  final String imagePath;
  final Color? borderColor;
  final Color? backgroundColor;

  const SocialButtonsWidget({
    super.key,
    required this.imagePath,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: borderColor ?? Colors.blueAccent, width: 3),
      ),
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
