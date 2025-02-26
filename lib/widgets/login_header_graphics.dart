import 'package:demo_app/widgets/svg_picture_widget.dart';
import 'package:flutter/material.dart';

class LoginHeaderGraphicsWidget extends StatelessWidget {
  const LoginHeaderGraphicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width * 1.0,
      height: height * 0.27,
      child: Stack(children: [
        SvgPictureWidget(
            width: width,
            imagePath: 'assets/images/login_background_1st_layer.svg'),
        Positioned(
            right: 0,
            child: SvgPictureWidget(
              imagePath: 'assets/images/login_background_3rd_layer.svg',
              width: width * 0.40,
              height: height * 0.25,
            )),
        SvgPictureWidget(
          width: width,
          imagePath: 'assets/images/login_background_2nd_layer.svg',
        ),
        Padding(
          padding: EdgeInsets.only(left: width * 0.15, top: height * 0.08),
          child: Text(
            'Welcome\nBack',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 40),
          ),
        ),
      ]),
    );
  }
}
