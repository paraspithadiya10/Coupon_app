import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgPictureWidget extends StatelessWidget {
  const SvgPictureWidget(
      {super.key, this.width, required this.imagePath, this.height});

  final double? width;
  final double? height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      width: width,
      height: height,
      imagePath,
      fit: BoxFit.fill,
    );
  }
}
