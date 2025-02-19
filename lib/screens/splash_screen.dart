import 'package:demo_app/widgets/social_buttons_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: Container(
          height: height * 0.2,
          width: width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.black),
          ),
          child:
              SocialButtonsWidget(imagePath: 'assets/images/adidas_logo.png'),
        ),
      ),
    );
  }
}
